#Terraform setup
terraform {
  required_providers {
     aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}



# 1. Create VPC

resource "aws_vpc" "Creating_our_first_VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "VPC by Terraform"
  }
}

# 2. Create a private subnet
resource "aws_subnet" "first-subnet" {
  vpc_id     = aws_vpc.Creating_our_first_VPC.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private subnet"
  }
}

# 3. Create an s3 bucket
resource "aws_s3_bucket" "bucket-1" {
  bucket = "my-first-lmtd-bucket"
  acl    = "private"

  tags = {
    Name        = "bucket from terraform"
    Environment = "Dev"
  }
}

# 4. Create an EC2 and install docker
resource "aws_instance" "ec2_instance" {
  ami           = "ami-047a51fa27710816e" # us-east-1
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  user_data = <<-EOF
		#!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo yum install docker git python3 -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    EOF
    tags = {
      Name = "EC2 With Docker"
    }
}
