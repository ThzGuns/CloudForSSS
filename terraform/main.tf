terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}

provider "aws" {
  region = var.AwsRegion
  access_key = var.AWSAccessKey
  secret_key = var.AWSSecretKey
}

# Default VPC
data "aws_vpc" "default_vpc" {
  default = true
}

# Subnets in default VPC
data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}
