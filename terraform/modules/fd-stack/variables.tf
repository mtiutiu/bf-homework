variable "environment" {
  type        = string
  description = "The environment used to deploy this stack to"
}

variable "app_name" {
  type        = string
  description = "The application stack name that's going to be deployed"
}

variable "app_version" {
  type        = string
  description = "The application stack version that's going to be deployed"
  default     = "0.0.0"
}

variable "tags" {
  type        = map(any)
  description = "The application stack resources tags"
}

variable "dlq_sqs_max_receive_count" {
  type        = number
  description = "The application stack DLQ max receive count"
  default     = 10
}

variable "dynamo_table_deletion_protection" {
  type        = bool
  description = "Enable deletion protection for the application stack DynamoDB table"
  default     = false
}

variable "app_lambda_timeout" {
  type        = number
  description = "The application stack lambda execution timeout"
  default     = 30
}

variable "app_lambda_memory_mb" {
  type        = number
  description = "The application stack lambda memory limit in MB"
  default     = 128
}
