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

