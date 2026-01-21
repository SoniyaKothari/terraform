data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "web" {
  count         = 2
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = data.aws_subnets.default.ids[count.index]

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<EOF
#!/bin/bash
yum install -y nginx
systemctl start nginx
systemctl enable nginx
echo "Hello from EC2 instance ${count.index + 1}" > /usr/share/nginx/html/index.html
EOF

  tags = {
    Name = "web-${count.index + 1}"
  }
}
