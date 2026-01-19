terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_sqs_queue" "dlq" {
  name                      = "simple-dlq"
  message_retention_seconds = 1209600 # 14 days

  tags = {
    Purpose = "dead-letter-queue"
    Env     = "dev"
  }
}

resource "aws_sqs_queue" "main" {
  name                      = "simple-main-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600 # 4 days

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })

  tags = {
    Purpose = "main-processing-queue"
    Env     = "dev"
  }
}
