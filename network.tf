resource "aws_eip" "example_eip" {
  domain = "vpc"

  tags = {
    Name = "example-eip"
  }
}

resource "aws_security_group" "basic_sg" {
  name        = "basic-sg"
  description = "Basic security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "basic-sg"
  }
}
