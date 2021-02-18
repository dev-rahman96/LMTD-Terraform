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

