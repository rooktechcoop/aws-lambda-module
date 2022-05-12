module "hello_world" {
  source = "../../"

  lambda_function_name = "hello-world"
  lambda_code_path     = ["${path.module}/python/source/hello_world.py", "${path.module}/python/source/Config.py"]
  lambda_handler       = "helloworld.lambda_handler"
  lambda_runtime       = "python3.8"
  lambda_policy_arn = [
    aws_iam_policy.iampolicy_logs.arn,
  ]
  lambda_description = "Hello world lambda"
  lambda_timeout     = "240"

  environment = {
    variables = {
      greet = "(Y)"
    }
  }

  tags = { "state" = "terraform managed" }
}
