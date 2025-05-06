output "app_lambda_function_arn" {
  description = "App lambda function ARN"
  value       = aws_lambda_function.app_runtime.arn
}

output "app_dynamodb_users_table_arn" {
  description = "App DynamoDB users table ARN"
  value       = aws_dynamodb_table.app_users.arn
}

output "app_sqs_queue_arn" {
  description = "App SQS queue ARN"
  value       = aws_sqs_queue.app_queue.arn
}
