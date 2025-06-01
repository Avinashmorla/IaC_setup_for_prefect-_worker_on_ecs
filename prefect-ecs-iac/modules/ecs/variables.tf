variable "cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
}

variable "dns_namespace" {
  description = "Private DNS namespace for service discovery"
  type        = string
  default     = "default.prefect.local"
}

variable "vpc_id" {
  description = "VPC ID to associate the Cloud Map namespace"
  type        = string
}

variable "project_tag" {
  description = "Tag to apply to ECS resources"
  type        = string
}

