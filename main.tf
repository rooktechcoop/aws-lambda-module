data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${var.lambda_function_name}.zip"

  dynamic "source" {
    for_each = var.lambda_files

    content {
      filename = basename(source.value)
      content  = file(source.value)
    }
  }

}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = var.lambda_code_path
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
  tags             = var.tags
  layers           = var.lambda_layers
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size

  dynamic "environment" {
    for_each = var.environment
    content {
      variables = environment.value.variables
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda_cwgroup" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.cw_logs_retention_days
}


resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_function_name}-role"

  assume_role_policy = data.aws_iam_policy_document.lambda_role_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_iam_role_policy_attachment" {
  count = length(var.lambda_policy_arn)

  role       = aws_iam_role.lambda_role.name
  policy_arn = var.lambda_policy_arn[count.index] #element(var.lambda_policy_arn, count.index)
}
