terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-2"
}

# resource "aws_instance" "GoPhish_Instance" {
#   ami                    = "ami-04f5097681773b989"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_default_subnet.default_az1.id
#   vpc_security_group_ids = [aws_security_group.allow_ssh.id]
#   key_name               = aws_key_pair.access_key.key_name
#   tags = {
#     Name = "GoPhish-Phishing"
#   }
# }

# resource "aws_instance" "EvilGinx_Instance" {
#   ami                    = "ami-04f5097681773b989"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_default_subnet.default_az1.id
#   vpc_security_group_ids = [aws_security_group.allow_ssh.id]
#   key_name               = aws_key_pair.access_key.key_name
#   tags = {
#     Name = "EvilGinx-Phishing"
#   }
# }

resource "aws_instance" "EvilGinx_GoPhish_Instance" {
  ami                    = "ami-04f5097681773b989"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.access_key.key_name
  tags = {
    Name = "EvilGinx3-GoPhish-Phishing"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "Default subnet for ap-southeast-2a"
  }
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh-phishing"
  description = "Allow SSH access from a specific IP + Cloudflare"

  vpc_id = aws_default_vpc.default.id

  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["20.211.107.191/32"] # Update with the specific IP address for your VM
  # }

  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["13.239.158.0/29"] # Update with the specific IP address for your VM
  # }


  # Cloudflare IPs - https://www.cloudflare.com/ips-v4/
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "173.245.48.0/20",
      "103.21.244.0/22",
      "103.22.200.0/22",
      "103.31.4.0/22",
      "141.101.64.0/18",
      "108.162.192.0/18",
      "190.93.240.0/20",
      "188.114.96.0/20",
      "197.234.240.0/22",
      "198.41.128.0/17",
      "162.158.0.0/15",
      "104.16.0.0/13",
      "104.24.0.0/14",
      "172.64.0.0/13",
      "131.0.72.0/22"
    ]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Get a EC2 Key Pair including the public key material from its name
resource "aws_key_pair" "access_key" {
  key_name   = "Access_Key"
  public_key = "ssh-rsa AAAA...." # Insert created public key here
}


