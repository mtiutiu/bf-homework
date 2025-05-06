# App DynamoDB users table
resource "aws_dynamodb_table" "app_users" {
  name         = "${var.environment}_UsersTable"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "ID"
  range_key = "userId"

  attribute {
    name = "ID"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  ttl {
    attribute_name = "TTL"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  deletion_protection_enabled = var.dynamo_table_deletion_protection
  tags                        = var.tags
}

# App lambda DynamoDB processing IAM policy
data "aws_iam_policy_document" "dynamodb_processing" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]
    resources = [
      aws_dynamodb_table.app_users.arn,
    ]
  }
}

resource "aws_iam_role_policy" "dynamodb_processing" {
  name   = "${var.environment}-${var.app_name}-dynamodb-policy"
  policy = data.aws_iam_policy_document.dynamodb_processing.json
  role   = aws_iam_role.app_lambda_permissions.id
}
