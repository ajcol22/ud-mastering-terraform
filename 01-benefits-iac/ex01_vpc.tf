# Terraform provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider region
provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "vpc_ex02" {
  cidr_block = "10.0.0.0/16"

    tags = {
    Name = "Terraform VPC Ex02"
  }
}

# Public subnet
resource "aws_subnet" "public_subnet_ex02" {
  vpc_id     = aws_vpc.vpc_ex02.id
  cidr_block = "10.0.0.0/24"
}

# Private subnet
resource "aws_subnet" "private_subnet_ex02" {
  vpc_id     = aws_vpc.vpc_ex02.id
  cidr_block = "10.0.1.0/24"
}

# Internet gateway
resource "aws_internet_gateway" "igw_ex02" {
  vpc_id = aws_vpc.vpc_ex02.id
}

# Route table
resource "aws_route_table" "public_rtable_ex02" {
  vpc_id = aws_vpc.vpc_ex02.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_ex02.id
  }
}

# Connecting route table to public subnet
resource "aws_route_table_association" "public_subnet_ex02" {
  subnet_id      = aws_subnet.public_subnet_ex02.id
  route_table_id = aws_route_table.public_rtable_ex02.id
}


