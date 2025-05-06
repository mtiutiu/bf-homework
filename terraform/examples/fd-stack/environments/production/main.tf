locals {
  aws_region  = "us-east-1"
  environment = "production"
}

module "fd_microservice_1" {
  source = "../../../../modules/fd-stack"

  app_name                         = "fd-microservice-1"
  app_version                      = "0.0.1"
  environment                      = local.environment
  dlq_sqs_max_receive_count        = 3
  dynamo_table_deletion_protection = true

  tags = {
    Environment = local.environment
    Company     = "BF"
    Project     = "FD"
  }
}
