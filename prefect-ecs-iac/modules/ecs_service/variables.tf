variable "prefect_api_key" {
  type        = string
  description = "Prefect API key (stored in Secrets Manager)"
  sensitive   = true
}

variable "prefect_api_url" {
  type = string
}

variable "work_pool_name" {
  type    = string
  default = "ecs-work-pool"
}

variable "prefect_account_id" {
  type = string
}

variable "prefect_workspace_id" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "ecs_cluster_arn" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}
variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}
variable "container_image" {
  type        = string
  description = "Container image URI to use for the Prefect worker"
}
variable "dockerhub_credentials_secret_arn" {
  description = "ARN of the DockerHub credentials secret"
  type        = string
}

