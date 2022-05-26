module "hello_world" {
  source = "../../"

  lambda_function_name = "hello_world_v3"
  lambda_code_path     = ["${path.module}/python/source/hello_world.py", "${path.module}/python/source/Config.py"]
  lambda_handler       = "hello_world.lambda_handler"
  lambda_runtime       = "python3.8"
  lambda_description   = "Hello world lambda module version 3"
  lambda_timeout       = "240"

  environment = {
    variables = {
      greet = "(Y)"
    }
  }

  tags = { "state" = "terraform managed v3" }
}
