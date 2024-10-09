# Provider Configuration
provider "aws" {
  region = "us-east-1"
}

# VPC Creation
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-secure-vpc"
    Environment = "Production"
  }
}

# Create an Internet Gateway for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-secure-igw"
    Environment = "Production"
  }
}
