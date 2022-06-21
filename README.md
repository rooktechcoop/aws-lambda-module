# LAMBDA MODULE

A brief description of how this modules must be instantiated:

## Usage example

```hcl
module "hello_world" {
  source = "git::https://github.com/rooktechcoop/aws-lambda-module"

  lambda_function_name = "hello_world"
  lambda_files_code_path     = ["${path.module}/python/source/hello_world.py", "${path.module}/python/source/Config.py"]
  lambda_handler       = "hello_world.lambda_handler"
  lambda_runtime       = "python3.8"
  lambda_policy_arn    = {"cognito" = aws_iam_policy.cognito_policy.arn, "s3" = aws_iam_policy.Lambda_S3.arn}
  lambda_description   = "Hello world lambda module"
  lambda_timeout       = "240"

  environment = {
    variables = {
      greeting = "World"
    }
  }

  tags = { "state" = "terraform managed v3" }
}
```

## Observation:
- For the lambda_policy_arn have to determinate a key like the example before the arn variable.
- For default, this module create a logs inline policy attached to the role.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:------:|:-----:|
| lambda_function_name | A name for the lambda | string | `-` | yes |
| lambda_folder_code_path| The path to the folder for your lamda code and packages. Conflicts whith `lambda_files_code_path` | string | `null` | no 
| lambda_files_code_path| The path to the files for your lamda code and packages. Conflicts whith `lambda_folder_code_path` | List | `[]` | no |
| lambda_handler | Lambda handler, e.g: `lambda_function.lambda_handler` | string | `lambda_function.lambda_handler` | yes |
| lambda_runtime | Lambda runtime, e.g: `python3.8` | string | - | yes |
| lambda_policy_arn | A list of policie's arn to attach to your lambda role | list(string) | `-` | no|
| lambda_description | Lambda runtime, e.g: `python3.8` | string | `"Some description for your lambda"` | no |
| lambda_timeout | A list of policie's arn to attach to your lambda role | int | 3 | no |
| lambda_layers| Dictionary of lambda layers arns | list | `null` | no |
| tags | Tags to attach to your function | map | `null` | no |


## Outputs

| Name | Description |
|------|-------------|
| lambda_arn | ARN of the Lambda |
| lambda_invoke_arn | ARN of the Lambda invoke uri ARN |
| lambda_role_arn | ARN of the Lambda role |
| lambda_role_id | ID of the Lambda role |
| lambda_role_name | Name of the Lambda role |
| lambda_name | Name of the Lambda |