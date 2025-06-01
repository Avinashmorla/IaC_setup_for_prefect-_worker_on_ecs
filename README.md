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
- **terraform init**        #initialises terraform
- <img width="626" alt="image" src="https://github.com/user-attachments/assets/c19ea8be-6178-4d56-8c54-adde4db7072b" />
- **terraform plan**        #plans the deployment of terraform
- <img width="431" alt="image" src="https://github.com/user-attachments/assets/4466d562-29b2-4b7b-8a32-44d7c55c9ae4" />
- <img width="365" alt="image" src="https://github.com/user-attachments/assets/55a37c5c-e91b-414e-bab1-bca859bb7d44" />


- **terraform apply**       #terraform will be applied
  <img width="590" alt="image" src="https://github.com/user-attachments/assets/b139cd9e-0332-466b-b453-4221c2518014" />


## Outputs
- After successful apply, Terraform will output:
- ecs_cluster_arn           = "arn:aws:ecs:us-east-1:638298051191:cluster/prefect-cluster"
- ecs_service_name          = prefect-worker-service
- private_subnets           = [subnet-091afaa9ee6cbb8e2, subnet-0be8b19e80d93f402, subnet-08cbc3fd73ba19da6]
- public_subnets            = [subnet-0f796d8fa9a55cb9b, subnet-053d9b4dd439393b5, subnet-05290c90b2c94a675]
- task_execution_role_arn   = arn:aws:iam::638298051191:role/prefect-task-execution-role
- vpc_id                    = vpc-***********(vpc_id)
- <img width="577" alt="image" src="https://github.com/user-attachments/assets/23e45c05-3f50-444e-a0be-d752d61f4201" />

## Verification
- **1.Go to the AWS ECS Console and verify:**
   - ->**VPC Configuration**
  - <img width="959" alt="image" src="https://github.com/user-attachments/assets/de17acc2-53ac-43fb-80c2-01b1bb5ae72c" />
    - ->**Cluster prefect-cluster exists**
 -  ![image](https://github.com/user-attachments/assets/99770193-bcaa-44c8-9c4a-837dca37e5fd)

- **2.In Prefect Cloud:
     - ->Go to Work Pools**
   -  **->Verify a pool named ecs-work-pool is present and active**
  - ![image](https://github.com/user-attachments/assets/ece4481b-0884-48bc-8d32-a2a7ac47d6af)
  - **NOTE- In prefect cloud, to deploy work pool with ecs type it required premium version .**
  - to deploy worker pool on ecs we need ecs type on prefect cloud but it has to be upgraded account.
  -  ![image](https://github.com/user-attachments/assets/32031311-b3e2-4dac-9b0a-f755dabe0ffa)
- **so what I have done is,With given default work pool I just verified with the sample flow file(flow.py) by downloading the prefect environment locally**
 - <img width="948" alt="image" src="https://github.com/user-attachments/assets/0632bcdd-8956-4e79-a12d-467551f4f593" /> 
- ![image](https://github.com/user-attachments/assets/fad94309-5f55-4cb8-b4c5-bb18aa583cfb) #sample flow python file

- **Trigger a sample flow to confirm worker is responsive**
- <img width="726" alt="image" src="https://github.com/user-attachments/assets/036f5d1d-7a1d-448a-8660-8bcb544be3a1" />
- ![image](https://github.com/user-attachments/assets/8f37c57c-b176-4809-80be-18b7d8ca57b1)
- <img width="952" alt="image" src="https://github.com/user-attachments/assets/ec49093b-2a8d-46c2-91c8-f783bb6e177b" />

## Cleanup Instructions
terraform destroy.  #destroys all the infrastructure 
![image](https://github.com/user-attachments/assets/27ecd638-628f-49d3-ae32-8fcd53caeaf6)

