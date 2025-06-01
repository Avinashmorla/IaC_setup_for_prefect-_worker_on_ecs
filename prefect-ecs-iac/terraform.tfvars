# terraform.tfvars

aws_region           = "us-east-1"
vpc_cidr             = "10.0.0.0/16"
project_tag          = "prefect-ecs"
prefect_api_key      = "pnu_sFjEVcaBbWusfxIMSluG3wr2SsiuMc42b3Vg"
prefect_api_url      = "https://api.prefect.cloud/api/accounts/917b078a-8e18-4f08-92f3-2f2c0ba32254/workspaces/88e5b4a2-028e-4ac8-95d7-ddbfb8afce87"
prefect_account_id   = "917b078a-8e18-4f08-92f3-2f2c0ba32254"
prefect_workspace_id = "88e5b4a2-028e-4ac8-95d7-ddbfb8afce87"
work_pool_name       = "ecs-work-pool"
task_role_arn        = "arn:aws:iam::<your-account-id>:role/prefect-ecs-task-role"
container_image      = "123456789012.dkr.ecr.us-east-1.amazonaws.com/prefect:2-latest"

