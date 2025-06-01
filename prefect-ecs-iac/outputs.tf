output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
output "task_execution_role_arn" {
  value = module.iam.task_execution_role_arn
}
output "ecs_cluster_arn" {
  value = module.ecs.cluster_arn
}
output "ecs_service_name" {
  value = module.ecs_service.ecs_service_name
}

