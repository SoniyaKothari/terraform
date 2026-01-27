# AWS Infrastructure Provisioning with Terraform

This repository contains Terraform configuration files to provision and manage AWS infrastructure components.
The setup is modular, readable, and focused on core AWS services commonly used in real projects.

The goal of this repo is to demonstrate clear and maintainable Infrastructure as Code using Terraform.

---

## Infrastructure Components

This project provisions the following AWS resources:

- VPC and networking components (VPC, subnets, routing)
- EC2 instance
- Elastic IP
- IAM roles and policies
- S3 bucket and bucket policy
- SQS queue
- Common tagging across resources

---

## Project Structure

.
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── network.tf
├── ec2.tf
├── eip.tf
├── iam.tf
├── object_storage.tf
├── s3_bucket.tf
├── s3_policy.tf
├── sqs.tf
└── tags.tf

---

## Prerequisites

- Terraform v1.3 or newer
- AWS CLI installed
- AWS credentials configured using aws configure
- AWS account with permissions for VPC, EC2, S3, SQS, and IAM

---

## How to Use

Initialize Terraform:

terraform init

Review the execution plan:

terraform plan

Apply the configuration:

terraform apply

Destroy all resources when no longer needed:

terraform destroy

---

## Notes

- This project uses a flat Terraform structure instead of modules for simplicity
- Variables can be extended to support multiple environments
- Terraform state files should not be committed to version control

---

## Purpose

This repository serves as a practical example of managing AWS infrastructure using Terraform.
It focuses on clarity, structure, and real-world AWS services rather than complexity.
