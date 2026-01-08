# key pair (login)

resource "aws_key_pair" my_key {
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
}

# VPC and Security Group

resource aws_default_vpc default {
  
}

resource aws_security_group my_sg{
    name = "automate-sg"
    description = "This will add a tf generated Security Group"
    # interpolation
    vpc_id = aws_default_vpc.default.id 
    
    # inbound rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        # optional
        description = "SSH Open"
    }

    # Can add more ingress based on ur requirement
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP Open"
    }

    # outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" # all protocols, all access
        cidr_blocks = ["0.0.0.0/0"]
        description = "All Access open of outbound"
    }

    tags = {
        Name = "automate-sg"
    }
}

# ec2 instance
resource "aws_instance" "my_first_instance" {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_sg.name]
    instance_type = "t2.micro"
    ami = "paste id from UI" # ubuntu

    # Configure Storage
    root_block_device {
      volume_size = 8
      volume_type = "gp3"
    }

    tags = {
      Name = "first-instance"  #Actual Name is given here
    }
}