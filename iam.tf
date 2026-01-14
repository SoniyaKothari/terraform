terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# IAM Role
resource "aws_iam_role" "basic_role" {
  name = "basic-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Policy
resource "aws_iam_policy" "basic_policy" {
  name = "basic-iam-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = [
        "s3:ListBucket",
        "s3:GetObject"
      ]
      Resource = "*"
    }]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.basic_role.name
  policy_arn = aws_iam_policy.basic_policy.arn
}
