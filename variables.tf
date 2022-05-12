variable "lambda_function_name" {
  description = "A name for the lambda"
}

variable "lambda_description" {
  default     = "Some description for your lambda"
  description = "Description to your lambda"
}
variable "lambda_handler" {
  description = "Lambda handler, e.g: lambda_function.lambda_handler"
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

variable "lambda_policy_arn" {
  description = "The ARNs of the policies to attach to the lambda role"
  type        = list(string)
}

variable "environment" {
  type = object({
    variables = map(string)
  })
  default = {}
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
