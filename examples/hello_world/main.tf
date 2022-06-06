module "hello_world" {
  source = "../../"

  lambda_function_name = "hello_world"
  lambda_code_path     = ["${path.module}/python/source/hello_world.py", "${path.module}/python/source/Config.py"]
  lambda_handler       = "hello_world.lambda_handler"
  lambda_runtime       = "python3.8"
  lambda_policy_arn    = [aws_iam_policy.Lambda_Watchlogs.arn]
  lambda_description   = "Hello world lambda module"
  lambda_timeout       = "240"

  environment = {
    variables = {
      greeting = "World"
    }
  }

  tags = { "state" = "terraform managed" }
}

resource "aws_iam_policy" "Lambda_Watchlogs" {
  name        = "Lambda-logsPolicy-policy"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = file("policies/Watchlog.json")
}