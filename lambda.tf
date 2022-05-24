data "archive_file" "lambda_zip" {
  type = "zip"
  dynamic "source" {
    for_each = var.lambda_code_path

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
  tags             = var.tags
  layers           = var.lambda_layers
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size

  environment {
    variables = {
      greeting = "Hello"
    }
  }
  # dynamic "environment" {
  #   for_each = var.environment = null ? [] : [var.environment]
  #   content {
  #     variables = environment.value.variables
  #   }
  # }
}

resource "aws_cloudwatch_log_group" "lambda_cwgroup" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.cw_logs_retention_days
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.lambda_function_name}-role"
  assume_role_policy = file("${path.module}/policies/LambdaBasicExecution.json")
}

resource "aws_iam_role_policy" "lambda_iam_role_policy" {
  name   = "lambda_iam_role_policy"
  role   = aws_iam_role.lambda_role.name
  policy = file("${path.module}/policies/Watchlog.json")
}