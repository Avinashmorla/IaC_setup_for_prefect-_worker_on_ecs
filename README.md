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
![image](https://github.com/user-attachments/assets/dbdba723-6828-426d-87f9-0e3a5b95ae3f)


## Configure terraform.tfvars
- Create and populate your terraform.tfvars file with necessary values like:
- aws_region         = "us-east-1"
- prefect_api_key    = "<your-prefect-api-key>"
- prefect_account_id = "<your-prefect-account-id>"
- prefect_workspace_id = "<your-prefect-workspace-id>"
- Note:These values are securely stored in AWS Secrets Manager.
- ![image](https://github.com/user-attachments/assets/0c3be2f8-87a3-475b-be4b-203d71b03617) 

## terraform Cycle
- terraform init        #initialises terraform
- <img width="626" alt="image" src="https://github.com/user-attachments/assets/c19ea8be-6178-4d56-8c54-adde4db7072b" />
- terraform plan        #plans the deployment of terraform
- ![image](https://github.com/user-attachments/assets/99353283-74f8-4af3-94f9-81f0fa3b4c7e)
- terraform apply       #terraform will be applied
- ![image](https://github.com/user-attachments/assets/74b69357-d1ad-4a79-9365-0e10f09ded64)


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
