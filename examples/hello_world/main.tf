module "hello_world" {
  source = "../../"

  lambda_function_name = "hello_world"
  lambda_folder_code_path     = "${path.module}/python/source"
  lambda_handler       = "hello_world.lambda_handler"
  lambda_runtime       = "python3.8"
  lambda_description   = "Hello world lambda module"
  lambda_timeout       = "240"

  environment = {
    variables = {
      greeting = "World"
    }
  }

  tags = { "state" = "terraform managed" }
}