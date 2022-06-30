data "archive_file" "lambda_zip" {
  type = "zip"

  source_dir = var.lambda_folder_code_path
  dynamic "source" {
    for_each = var.lambda_files_code_path

    content {
      filename = basename(source.value)
      content  = file(source.value)
    }
  }

  output_path = "${var.lambda_function_name}.zip"
}

resource "aws_lambda_function" "lambda" {

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_role.arn
  description      = var.lambda_description
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  layers           = var.lambda_layers
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) > 0 ? [var.environment_variables] : []
    content {
      variables = var.environment_variables
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "lambda_cwgroup" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.cw_logs_retention_days

  tags = var.tags
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.lambda_function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json

  tags = var.tags
}

data "aws_iam_policy_document" "policy_lambda_logs" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect    = "Allow"
    resources = ["${aws_cloudwatch_log_group.lambda_cwgroup.arn}:*"]
  }
}

resource "aws_iam_role_policy" "log_policy" {
  name   = "lambda_log_policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.policy_lambda_logs.json
}

resource "aws_iam_role_policy_attachment" "lambda_iam_role_policy_attachment" {
  for_each = var.lambda_policy_arn

  role       = aws_iam_role.lambda_role.name
  policy_arn = each.value
}
