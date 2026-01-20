variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH (your public IP /32)"
  type        = string
}
