resource "aws_secretsmanager_secret" "prefect_api_key" {
  name = "prefect_api_key-2"
}

resource "aws_secretsmanager_secret_version" "prefect_api_key_value" {
  secret_id     = aws_secretsmanager_secret.prefect_api_key.id
  secret_string = var.prefect_api_key
}

resource "aws_ecs_task_definition" "worker" {
  family                   = "prefect-dev-worker"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "prefect-worker",
      image     = "prefecthq/prefect:2-latest",
      command = ["prefect", "worker", "start", "-p", var.work_pool_name, "--type", "ecs"],
      essential = true,
      environment = [
        {
          name  = "PREFECT_API_URL"
          value = var.prefect_api_url
        },
        {
          name  = "EXTRA_PIP_PACKAGES"
          value = "prefect-aws s3fs"       
           },
        {
          name  = "PREFECT_WORK_POOL_NAME"
          value = var.work_pool_name
        },
        {
          name  = "PREFECT_ACCOUNT_ID"
          value = var.prefect_account_id
        },
        {
          name  = "PREFECT_WORKSPACE_ID"
          value = var.prefect_workspace_id
        }
      ],
      secrets = [
        {
          name      = "PREFECT_API_KEY",
          valueFrom = aws_secretsmanager_secret.prefect_api_key.arn
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/prefect-worker"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
       repositoryCredentials = {
        credentialsParameter = var.dockerhub_credentials_secret_arn
      }
    }
  ])
}

resource "aws_ecs_service" "worker" {
  name            = "prefect-worker-service"
  cluster         = var.ecs_cluster_arn
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.worker.arn
  desired_count   = 1

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.worker]
}

