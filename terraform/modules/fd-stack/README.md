## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.97.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.97.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.app_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_dynamodb_table.app_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_role.app_lambda_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.app_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.dynamodb_processing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.sqs_processing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_event_source_mapping.app_sqs_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.app_runtime](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_sqs_queue.app_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.app_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_redrive_allow_policy.app_queue_redrive_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_redrive_allow_policy) | resource |
| [archive_file.app_source_code](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.app_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.app_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dynamodb_processing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs_processing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_lambda_memory_mb"></a> [app\_lambda\_memory\_mb](#input\_app\_lambda\_memory\_mb) | The application stack lambda memory limit in MB | `number` | `128` | no |
| <a name="input_app_lambda_timeout"></a> [app\_lambda\_timeout](#input\_app\_lambda\_timeout) | The application stack lambda execution timeout | `number` | `30` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The application stack name that's going to be deployed | `string` | n/a | yes |
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | The application stack version that's going to be deployed | `string` | `"0.0.0"` | no |
| <a name="input_dlq_sqs_max_receive_count"></a> [dlq\_sqs\_max\_receive\_count](#input\_dlq\_sqs\_max\_receive\_count) | The application stack DLQ max receive count | `number` | `10` | no |
| <a name="input_dynamo_table_deletion_protection"></a> [dynamo\_table\_deletion\_protection](#input\_dynamo\_table\_deletion\_protection) | Enable deletion protection for the application stack DynamoDB table | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment used to deploy this stack to | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The application stack resources tags | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_dynamodb_users_table_arn"></a> [app\_dynamodb\_users\_table\_arn](#output\_app\_dynamodb\_users\_table\_arn) | App DynamoDB users table ARN |
| <a name="output_app_lambda_function_arn"></a> [app\_lambda\_function\_arn](#output\_app\_lambda\_function\_arn) | App lambda function ARN |
| <a name="output_app_sqs_queue_arn"></a> [app\_sqs\_queue\_arn](#output\_app\_sqs\_queue\_arn) | App SQS queue ARN |
