variable "lambda_prefix" {
  description = "Prefix for everything which is created by the module."
  type        = string
  default     = ""
}

variable "lambda_file_path" {
  description = "Path for the file which contains the lambda source code"
  type        = string
  default     = ""
}
