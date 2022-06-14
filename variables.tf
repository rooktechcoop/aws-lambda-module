variable "lambda_function_name" {
  description = "A name for the lambda"
}

variable "lambda_description" {
  default     = "Some description for your lambda"
  description = "Description to your lambda"
}
variable "lambda_handler" {
  description = "Lambda handler, e.g: lambda_function.lambda_handler"
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "Runtime of the lambda, e.g: python3.8"
}

variable "lambda_timeout" {
  description = "Execution lambda timeout"
  default     = 3
}

variable "lambda_memory_size" {
  description = "Runtime memory assigned to the lambda"
  default     = 128
}

variable "environment" {
  type = object({
    variables = map(string)
  })
   default = {
     variables:{}
   }
}

#Is the list of the files that are going to be source of the Lambda function.
variable "lambda_files_code_path" {
  type    = list(string)
  default = []
}

#Is the folder where the source files for the Lambda function are.
variable "lambda_folder_code_path" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "lambda_layers" {
  description = "The ARNs of lambda layers"
  type        = list(string)
  default     = null
}

variable "cw_logs_retention_days" {
  description = "Number of retention days of the lambda log group in Cloudwatch"
  type        = number
  default     = 14
}

variable "lambda_policy_basic" {
  default = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

variable "iam_source_name" {
  type        = map(string)
  description = ""
  default = {
    default = "*"
  }
}

variable "lambda_policy_arn" {
  description = "The ARNs of the policies to attach to the lambda role"
  type        = map(string)
  default     = {}
}