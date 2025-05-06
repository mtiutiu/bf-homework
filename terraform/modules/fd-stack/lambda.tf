# App lambda identity for accessing other AWS services and resources
data "aws_iam_policy_document" "app_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "app_lambda_permissions" {
  name               = "${var.environment}-${var.app_name}-assume-role"
  assume_role_policy = data.aws_iam_policy_document.app_assume_role.json
}

data "archive_file" "app_source_code" {
  type        = "zip"
  source_file = "${path.module}/src/index.js"
  output_path = "${var.app_name}-${var.app_version}.zip"
}

resource "aws_lambda_function" "app_runtime" {
  filename         = data.archive_file.app_source_code.output_path
  function_name    = "${var.environment}-${var.app_name}"
  role             = aws_iam_role.app_lambda_permissions.arn
  tags             = var.tags
  timeout          = var.app_lambda_timeout
  memory_size      = var.app_lambda_memory_mb
  source_code_hash = data.archive_file.app_source_code.output_base64sha256
  runtime          = "nodejs18.x"
  handler          = "index.js"

  environment {
    variables = {
      # Useful for the app to check on which environment it runs
      ENVIRONMENT = var.environment
      # Useful to track current application version
      VERSION = var.app_version
      # SQS processing
      SQS_QUEUE_URL = aws_sqs_queue.app_queue.url
    }
  }
}

# App lambda CloudWatch logs & permissions
resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/lambda/${aws_lambda_function.app_runtime.function_name}"
  retention_in_days = 3
}

data "aws_iam_policy_document" "app_logs" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      aws_cloudwatch_log_group.app_logs.arn,
      "${aws_cloudwatch_log_group.app_logs.arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "app_logs" {
  name   = "${var.environment}-${var.app_name}-cloudwatch-logs"
  policy = data.aws_iam_policy_document.app_logs.json
  role   = aws_iam_role.app_lambda_permissions.id
}

# resource "aws_xray_group" "app_instrumentation" {
#   group_name        = "${var.environment}-${var.app_name}-xray"
#   filter_expression = "responsetime > 5"
# }
