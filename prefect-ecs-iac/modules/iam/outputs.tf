output "task_execution_role_arn" {
  description = "ARN of the IAM Task Execution Role"
  value       = aws_iam_role.task_execution_role.arn
}
output "task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.task_role.arn
}

