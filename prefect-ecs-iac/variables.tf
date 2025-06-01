variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_tag" {
  description = "Tag to apply to all resources"
  type        = string
  default     = "prefect-ecs"
}
variable "prefect_api_key" {
  description = "API key for Prefect Cloud"
  type        = string
  sensitive   = true
}
variable "prefect_api_url" {
  description = "URL of the Prefect API"
  type        = string
}

variable "prefect_account_id" {
  description = "Prefect Account ID"
  type        = string
}

variable "prefect_workspace_id" {
  description = "Prefect Workspace ID"
  type        = string
}

variable "work_pool_name" {
  description = "Name of the Prefect work pool"
  type        = string
}
variable "task_role_arn" {
  description = "IAM role ARN for ECS Task"
  type        = string
}
variable "container_image" {
  type        = string
  description = "ECR image URI for the Prefect worker"
}

