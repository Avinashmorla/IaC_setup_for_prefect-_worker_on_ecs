# Prefect ECS Fargate Deployment using Terraform

## Project Purpose
This project deploys a **Prefect worker** on **Amazon ECS (Fargate)** using **Terraform** as Infrastructure as Code (IaC). The deployment includes:
- A custom VPC with public and private subnets
- An ECS cluster and service
- IAM roles and policies
- Secrets stored securely in AWS Secrets Manager
- A Prefect worker connected to a Prefect Cloud work pool

## Why Terraform?
Terraform was chosen over AWS CloudFormation due to:
- first and foremost I am very vell known to **Terraform and it gives modular structure**.
- **Cloud-agnostic flexibility**, allowing future reuse across platforms.
- Strong **community support**, and better handling of **state management** and **versioning**.
- Rich ecosystem of **providers** and plugins.

## Repository Structure
- prefect-ecs-iac/
- ├── modules/
- │ ├── ecs/
- │ ├── ecs_service/
- │ ├── iam/
- │ ├── secrets/
- │ └── vpc/
- ├── terraform.tfvars
- ├── variables.tf
- ├── README.md

## Configure terraform.tfvars
- Create and populate your terraform.tfvars file with necessary values like:
- aws_region         = "us-east-1"
- prefect_api_key    = "<your-prefect-api-key>"
- prefect_account_id = "<your-prefect-account-id>"
- prefect_workspace_id = "<your-prefect-workspace-id>"
- Note:These values are securely stored in AWS Secrets Manager.

## terraform Cycle
- terraform init        #initialises terraform
- terraform plan        #plans the deployment of terraform
- terraform apply       #terraform will be applied 

## Outputs
- After successful apply, Terraform will output:
- ecs_cluster_arn           = "arn:aws:ecs:us-east-1:638298051191:cluster/prefect-cluster"
- ecs_service_name          = prefect-worker-service
- private_subnets           = [subnet-091afaa9ee6cbb8e2, subnet-0be8b19e80d93f402, subnet-08cbc3fd73ba19da6]
- public_subnets            = [subnet-0f796d8fa9a55cb9b, subnet-053d9b4dd439393b5, subnet-05290c90b2c94a675]
- task_execution_role_arn   = arn:aws:iam::638298051191:role/prefect-task-execution-role
- vpc_id                    = vpc-***********(vpc_id)

## Verification
- 1.Go to the AWS ECS Console and verify:
    ->Cluster prefect-cluster exists
    ->Service dev-worker is running in private subnets
- 2.In Prefect Cloud:
     ->Go to Work Pools
     ->Verify a pool named ecs-work-pool is present and active
(Optional) Trigger a sample flow to confirm worker is responsive
- **NOTE- In prefect cloud, to deploy work pool with ecs type it required premium version so what I have done is,With given default work pool I just verified with the sample flow file(flow.py) by downloading the prefect environment locally .** 

## Cleanup Instructions
terraform destroy.  #destroys all the infrastructure 
