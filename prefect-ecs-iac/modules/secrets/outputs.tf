output "secret_arn" {
  value = aws_secretsmanager_secret.prefect_api_key.arn
}
output "dockerhub_credentials_arn" {
  description = "The ARN of the DockerHub credentials secret"
  value       = aws_secretsmanager_secret.dockerhub_credentials.arn
}

