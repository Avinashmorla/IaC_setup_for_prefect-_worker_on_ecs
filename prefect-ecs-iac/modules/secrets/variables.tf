variable "prefect_api_key" {
  description = "The Prefect Cloud API Key"
  type        = string
  sensitive   = true
}

variable "project_tag" {
  description = "Tag to apply to resources"
  type        = string
}

