resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  service_connect_defaults {
    namespace = aws_service_discovery_private_dns_namespace.this.arn
  }

  tags = {
    Name = var.project_tag
  }
}

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = var.dns_namespace
  description = "Service discovery for ECS tasks"
  vpc         = var.vpc_id
}

