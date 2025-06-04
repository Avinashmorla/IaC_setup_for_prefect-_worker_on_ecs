# IaC Setup for Prefect Worker on ECS

## Overview  
![Architecture](https://github.com/user-attachments/assets/55c181d4-92e1-4542-afb8-8a0f415b6ace)



## 🚀 Project Overview
This project deploys a **Prefect worker** on **Amazon ECS (Fargate)** using **Terraform** as Infrastructure as Code (IaC). The deployment includes:
- A custom VPC with public and private subnets
- An ECS cluster and service
- IAM roles and policies
- Secrets stored securely in AWS Secrets Manager
- A Prefect worker connected to a Prefect Cloud work pool


## 🔧 Why Terraform?
Terraform was chosen over AWS CloudFormation because:
- I’m well-versed in **Terraform**, which supports modular architecture.
- **Cloud-agnostic flexibility**, enabling future reuse across providers.
- Excellent **state management**, **versioning**, and **community support**.
- Rich ecosystem of **providers** and plugins.



## 📁 Repository Structure
```
prefect-ecs-iac/
├── modules/
│   ├── ecs/
│   ├── ecs_service/
│   ├── iam/
│   ├── secrets/
│   └── vpc/
├── terraform.tfvars
├── variables.tf
├── README.md
```

![Repo Structure](https://github.com/user-attachments/assets/dbdba723-6828-426d-87f9-0e3a5b95ae3f)



## ⚙️ Prerequisites
- Terraform `>= 1.5.0`
- AWS CLI configured
- AWS Provider `>= 5.0`
- Prefect Cloud account and API key



## ⚡ Quick Start

```bash
git clone https://github.com/yourusername/prefect-ecs-iac.git
cd prefect-ecs-iac
terraform init
terraform apply
```

> Ensure your `terraform.tfvars` is configured correctly before running `apply`.



## 🔐 terraform.tfvars Configuration

```hcl
aws_region            = "us-east-1"
prefect_api_key       = "<your-prefect-api-key>"
prefect_account_id    = "<your-prefect-account-id>"
prefect_workspace_id  = "<your-prefect-workspace-id>"
```

These values are securely stored in **AWS Secrets Manager**.

![Secrets](https://github.com/user-attachments/assets/0c3be2f8-87a3-475b-be4b-203d71b03617)



## 🛠️ Terraform Commands

**Initialize**
```bash
terraform init
```
![init](https://github.com/user-attachments/assets/c19ea8be-6178-4d56-8c54-adde4db7072b)

**Plan**
```bash
terraform plan
```
![plan1](https://github.com/user-attachments/assets/4466d562-29b2-4b7b-8a32-44d7c55c9ae4)
![plan2](https://github.com/user-attachments/assets/55a37c5c-e91b-414e-bab1-bca859bb7d44)

**Apply**
```bash
terraform apply
```
![apply](https://github.com/user-attachments/assets/b139cd9e-0332-466b-b453-4221c2518014)



## 📤 Terraform Output

```
ecs_cluster_arn         = "arn:aws:ecs:us-east-1:638298051191:cluster/prefect-cluster"
ecs_service_name        = prefect-worker-service
private_subnets         = [subnet-091afaa9ee6cbb8e2, subnet-0be8b19e80d93f402, subnet-08cbc3fd73ba19da6]
public_subnets          = [subnet-0f796d8fa9a55cb9b, subnet-053d9b4dd439393b5, subnet-05290c90b2c94a675]
task_execution_role_arn = arn:aws:iam::638298051191:role/prefect-task-execution-role
vpc_id                  = vpc-*********** (vpc_id)
```

![Output](https://github.com/user-attachments/assets/23e45c05-3f50-444e-a0be-d752d61f4201)



## ✅ Verification

### 🔍 In AWS Console
- Confirm VPC, ECS Cluster, and Service creation:
  ![VPC Config](https://github.com/user-attachments/assets/de17acc2-53ac-43fb-80c2-01b1bb5ae72c)
  ![Cluster](https://github.com/user-attachments/assets/99770193-bcaa-44c8-9c4a-837dca37e5fd)

### 🔍 In Prefect Cloud
- Navigate to **Work Pools**
- Verify a pool named `ecs-work-pool` is present and active  
  ![Work Pool](https://github.com/user-attachments/assets/ece4481b-0884-48bc-8d32-a2a7ac47d6af)

> ⚠️ **Note:** Prefect Cloud requires a **premium account** for ECS-based work pools.  
> Since the free account doesn't support ECS work pools, I tested using a default local work pool.

![Upgrade Note](https://github.com/user-attachments/assets/32031311-b3e2-4dac-9b0a-f755dabe0ffa)



## 🧪 Flow Execution Demo

I verified worker functionality using a local Prefect flow (`flow.py`):

![Local Flow](https://github.com/user-attachments/assets/0632bcdd-8956-4e79-a12d-467551f4f593)
![Code](https://github.com/user-attachments/assets/fad94309-5f55-4cb8-b4c5-bb18aa583cfb)

**Triggering the flow:**
![Flow Trigger](https://github.com/user-attachments/assets/036f5d1d-7a1d-448a-8660-8bcb544be3a1)
![Output 1](https://github.com/user-attachments/assets/8f37c57c-b176-4809-80be-18b7d8ca57b1)
![Output 2](https://github.com/user-attachments/assets/ec49093b-2a8d-46c2-91c8-f783bb6e177b)



## 🧹 Cleanup Instructions

To destroy all infrastructure:
```bash
terraform destroy
```
![Destroy](https://github.com/user-attachments/assets/27ecd638-628f-49d3-ae32-8fcd53caeaf6)

