resource "aws_sqs_queue" "app_queue" {
  name = "${var.environment}-${var.app_name}"
  tags = var.tags

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.app_dlq.arn
    maxReceiveCount     = var.dlq_sqs_max_receive_count
  })
}

resource "aws_sqs_queue" "app_dlq" {
  name = "${var.environment}-${var.app_name}-dlq"
  tags = var.tags
}

resource "aws_sqs_queue_redrive_allow_policy" "app_queue_redrive_policy" {
  queue_url = aws_sqs_queue.app_dlq.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.app_queue.arn]
  })
}

# App lambda function SQS trigger
resource "aws_lambda_event_source_mapping" "app_sqs_trigger" {
  event_source_arn = aws_sqs_queue.app_queue.arn
  function_name    = aws_lambda_function.app_runtime.arn
  enabled          = true
  batch_size       = 5
}

# App lambda SQS processing IAM policy
data "aws_iam_policy_document" "sqs_processing" {
  statement {
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl"
    ]
    resources = [
      aws_sqs_queue.app_queue.arn,
    ]
  }
}

resource "aws_iam_role_policy" "sqs_processing" {
  name   = "${var.environment}-${var.app_name}-sqs-policy"
  policy = data.aws_iam_policy_document.sqs_processing.json
  role   = aws_iam_role.app_lambda_permissions.id
}
