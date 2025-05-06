locals {
  aws_region  = "us-east-1"
  environment = "development"
}

module "fd_microservice_1" {
  source = "../../../../modules/fd-stack"

  app_name    = "fd-microservice-1"
  app_version = "0.0.1"
  environment = local.environment

  tags = {
    Environment = local.environment
    Company     = "BF"
    Project     = "FD"
  }
}
