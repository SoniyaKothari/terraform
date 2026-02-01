# AWS Infrastructure Provisioning with Terraform

[![Terraform](https://img.shields.io/badge/Terraform-v1.3+-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazon-aws)](https://aws.amazon.com/)

This repository contains Terraform configuration files to provision and manage AWS infrastructure components. The setup is modular, readable, and follows AWS best practices for creating production-ready cloud infrastructure.

---

## 📋 Table of Contents

- [Infrastructure Components](#infrastructure-components)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Usage](#usage)
- [Outputs](#outputs)
- [Security Considerations](#security-considerations)
- [Cost Estimation](#cost-estimation)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## 🏗️ Infrastructure Components

This project provisions the following AWS resources:

| Resource | Purpose | File |
|----------|---------|------|
| **VPC** | Virtual Private Cloud with custom CIDR | `network.tf` |
| **Subnets** | Public and private subnets across AZs | `network.tf` |
| **Internet Gateway** | Internet connectivity for public subnets | `network.tf` |
| **Route Tables** | Routing configuration for subnets | `network.tf` |
| **EC2 Instance** | Compute instance with custom configuration | `ec2.tf` |
| **Elastic IP** | Static public IP address for EC2 | `eip.tf` |
| **IAM Roles & Policies** | Identity and access management | `iam.tf` |
| **S3 Bucket** | Object storage with versioning | `s3_bucket.tf` |
| **S3 Bucket Policy** | Access control for S3 resources | `s3_policy.tf` |
| **SQS Queue** | Message queuing service | `sqs.tf` |
| **Resource Tags** | Consistent tagging across all resources | `tags.tf` |

---

## 📁 Project Structure

```
terraform/
├── provider.tf           # AWS provider configuration
├── variables.tf          # Variable declarations
├── terraform.tfvars      # Variable values (DO NOT commit sensitive data)
├── network.tf           # VPC, subnets, IGW, route tables
├── ec2.tf               # EC2 instance configuration
├── eip.tf               # Elastic IP allocation and association
├── iam.tf               # IAM roles, policies, and attachments
├── object_storage.tf    # Object storage configuration
├── s3_bucket.tf         # S3 bucket creation and settings
├── s3_policy.tf         # S3 bucket policies
├── sqs.tf               # SQS queue configuration
├── tags.tf              # Common tags for resource management
└── README.md            # This file
```

---

## ✅ Prerequisites

Before you begin, ensure you have the following installed and configured:

- **Terraform** v1.3 or newer ([Download](https://www.terraform.io/downloads))
- **AWS CLI** v2.x ([Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
- **AWS Account** with appropriate permissions
- **Git** (for version control)

### Required AWS Permissions

Your IAM user/role needs permissions for:
- VPC (create, modify, delete)
- EC2 (launch instances, manage EIPs)
- S3 (create buckets, manage policies)
- SQS (create queues, manage attributes)
- IAM (create roles and policies)

### AWS CLI Configuration

Configure your AWS credentials:

```bash
aws configure
```

You'll be prompted to enter:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., `us-east-1`)
- Default output format (e.g., `json`)

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/SoniyaKothari/terraform.git
cd terraform
```

### 2. Initialize Terraform

Download required providers and modules:

```bash
terraform init
```

### 3. Configure Variables

Create or edit `terraform.tfvars` with your values:

```hcl
# Example terraform.tfvars
aws_region     = "us-east-1"
project_name   = "my-project"
environment    = "dev"
instance_type  = "t2.micro"
vpc_cidr       = "10.0.0.0/16"
```

### 4. Review the Plan

Preview the changes Terraform will make:

```bash
terraform plan
```

### 5. Apply Configuration

Create the infrastructure:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 6. View Outputs

After successful deployment:

```bash
terraform output
```

---

## ⚙️ Configuration

### Key Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region for resources | `us-east-1` | Yes |
| `project_name` | Name prefix for resources | - | Yes |
| `environment` | Environment (dev/staging/prod) | `dev` | Yes |
| `vpc_cidr` | CIDR block for VPC | `10.0.0.0/16` | No |
| `instance_type` | EC2 instance type | `t2.micro` | No |
| `enable_versioning` | Enable S3 versioning | `true` | No |

### Example `terraform.tfvars`

```hcl
aws_region    = "us-west-2"
project_name  = "demo-app"
environment   = "production"
instance_type = "t3.medium"
vpc_cidr      = "10.1.0.0/16"

tags = {
  Owner       = "DevOps Team"
  CostCenter  = "Engineering"
  Compliance  = "PCI-DSS"
}
```

---

## 💻 Usage

### Common Commands

```bash
# Initialize working directory
terraform init

# Format code to canonical style
terraform fmt

# Validate configuration files
terraform validate

# Create execution plan
terraform plan

# Apply changes
terraform apply

# Apply without confirmation prompt
terraform apply -auto-approve

# Destroy all resources
terraform destroy

# Show current state
terraform show

# List all resources in state
terraform state list

# View specific output
terraform output instance_public_ip
```

### Targeting Specific Resources

Apply changes to specific resources only:

```bash
# Apply only EC2 changes
terraform apply -target=aws_instance.main

# Destroy only S3 bucket
terraform destroy -target=aws_s3_bucket.main
```

---

## 📤 Outputs

After deployment, Terraform outputs the following information:

| Output | Description |
|--------|-------------|
| `vpc_id` | VPC identifier |
| `public_subnet_ids` | List of public subnet IDs |
| `private_subnet_ids` | List of private subnet IDs |
| `ec2_instance_id` | EC2 instance identifier |
| `ec2_public_ip` | Public IP address of EC2 |
| `elastic_ip` | Elastic IP address |
| `s3_bucket_name` | Name of created S3 bucket |
| `s3_bucket_arn` | ARN of S3 bucket |
| `sqs_queue_url` | URL of SQS queue |
| `iam_role_arn` | ARN of IAM role |

---

## 🔒 Security Considerations

### State File Management

**⚠️ CRITICAL:** Terraform state files contain sensitive information.

#### Local State (Current Setup)
- **Never commit** `terraform.tfstate` or `terraform.tfstate.backup` to version control
- Add to `.gitignore`:
  ```
  # Terraform files
  *.tfstate
  *.tfstate.*
  *.tfvars
  .terraform/
  ```

#### Recommended: Remote State

For production environments, use remote state backend:

```hcl
# Add to provider.tf
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
```

### Best Practices

1. **Secrets Management**
   - Never hardcode credentials in `.tf` files
   - Use AWS Secrets Manager or Parameter Store
   - Utilize environment variables for sensitive data

2. **IAM Least Privilege**
   - Grant minimum necessary permissions
   - Use IAM roles instead of access keys where possible
   - Regularly audit IAM policies

3. **Network Security**
   - Implement security groups with restrictive rules
   - Use private subnets for sensitive resources
   - Enable VPC Flow Logs for monitoring

4. **S3 Security**
   - Enable encryption at rest
   - Block public access by default
   - Enable versioning for critical buckets
   - Implement bucket policies carefully

5. **Resource Tagging**
   - Tag all resources for cost tracking
   - Include environment, owner, and project tags
   - Use consistent naming conventions

---

## 💰 Cost Estimation

Approximate monthly AWS costs (us-east-1 region):

| Resource | Configuration | Est. Cost/Month |
|----------|--------------|-----------------|
| EC2 (t2.micro) | 730 hours | ~$8.50 |
| Elastic IP | When associated | Free |
| Elastic IP | When unassociated | ~$3.60 |
| S3 Bucket | First 50TB | ~$0.023/GB |
| SQS Queue | First 1M requests | Free |
| Data Transfer | Varies | Variable |

**Total Estimated Cost:** ~$10-15/month (minimal usage)

💡 **Tip:** Use [AWS Pricing Calculator](https://calculator.aws/) for detailed estimates.

---

## 🔧 Troubleshooting

### Common Issues

#### Issue: "Error: No valid credential sources found"

**Solution:**
```bash
# Verify AWS credentials
aws sts get-caller-identity

# Reconfigure if needed
aws configure
```

#### Issue: "Error: creating EC2 Instance: VPCIdNotSpecified"

**Solution:**
- Ensure VPC is created before EC2 instance
- Check dependency chains in your configuration

#### Issue: "Error: Provider configuration not present"

**Solution:**
```bash
# Reinitialize Terraform
rm -rf .terraform
terraform init
```

#### Issue: State Lock Errors

**Solution:**
```bash
# Force unlock (use with caution)
terraform force-unlock <LOCK_ID>
```

### Debugging

Enable detailed logging:

```bash
export TF_LOG=DEBUG
terraform apply
```

Log levels: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`

---

## 🛠️ Advanced Usage

### Using Workspaces

Manage multiple environments:

```bash
# Create new workspace
terraform workspace new staging

# List workspaces
terraform workspace list

# Switch workspace
terraform workspace select production

# Show current workspace
terraform workspace show
```

### Import Existing Resources

Import existing AWS resources:

```bash
# Import EC2 instance
terraform import aws_instance.main i-1234567890abcdef0

# Import S3 bucket
terraform import aws_s3_bucket.main my-existing-bucket
```

---

## 📚 Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards

- Run `terraform fmt` before committing
- Validate with `terraform validate`
- Update documentation for new variables/outputs
- Follow existing naming conventions

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Authors

**Soniya Kothari**
- GitHub: [@SoniyaKothari](https://github.com/SoniyaKothari)

---

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Troubleshooting](#troubleshooting) section
2. Review [GitHub Issues](https://github.com/SoniyaKothari/terraform/issues)
3. Open a new issue with detailed information

---

## 🔄 Changelog

### [Latest]
- Initial infrastructure setup
- VPC with public/private subnets
- EC2 instance with Elastic IP
- S3 bucket with policies
- SQS queue integration
- IAM roles and policies
- Resource tagging strategy

---
