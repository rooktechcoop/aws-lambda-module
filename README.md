# AWS Lambda Terraform module

Terraform module, which creates AWS Lambda.

## Usage

### Lambda Function (store package locally)

```hcl
module "hello_world" {
  source = "../lambda"

  lambda_function_name = "${var.name}-get-instance-status"
  lambda_code_path     = ["${path.module}/python/source/hello_world.py", "${path.module}/python/source/Config.py"]
  lambda_handler       = "helloworld.lambda_handler"
  lambda_runtime       = "python3.8"
  lambda_policy_arn = [
    aws_iam_policy.iampolicy_logs.arn,
  ]
  lambda_description = "Hello world lambda"
  lambda_timeout     = "240"
  lambda_layers = [aws_lambda_layer_version.requests.arn]

  environment = {
    variables = {
      greet = "hello world"
    }
  }

  tags = {"state"="terraform managed"}
}
```