# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source          = "./modules/vpc"
  name            = "prefect-vpc"
  vpc_cidr        = var.vpc_cidr
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  project_tag     = var.project_tag
}
module "iam" {
  source      = "./modules/iam"
  role_name   = "prefect-task-execution-role"
  project_tag = var.project_tag
}
module "ecs" {
  source       = "./modules/ecs"
  cluster_name = "prefect-cluster"
  vpc_id       = module.vpc.vpc_id
  project_tag  = var.project_tag
}
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-fargate-sg"
  description = "Allow ECS Fargate tasks egress-only access"
  vpc_id      = module.vpc.vpc_id

  # No ingress — Fargate task is not exposed to the internet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
  }

  # Full outbound access to internet (NAT Gateway will be used)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prefect-ecs"
  }
}

module "ecs_service" {
  source                           = "./modules/ecs_service"
  prefect_api_key                  = var.prefect_api_key
  prefect_api_url                  = var.prefect_api_url
  work_pool_name                   = var.work_pool_name
  prefect_account_id               = var.prefect_account_id
  prefect_workspace_id             = var.prefect_workspace_id
  execution_role_arn               = module.iam.task_execution_role_arn
  task_role_arn                    = module.iam.task_role_arn
  ecs_cluster_arn                  = module.ecs.cluster_arn
  private_subnets                  = module.vpc.private_subnets
  security_group_id                = aws_security_group.ecs_sg.id
  container_image                  = var.container_image
  dockerhub_credentials_secret_arn = module.secrets.dockerhub_credentials_arn

}
module "secrets" {
  source          = "./modules/secrets"
  project_tag     = var.project_tag
  prefect_api_key = var.prefect_api_key
}
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/prefect-worker"
  retention_in_days = 7
}


