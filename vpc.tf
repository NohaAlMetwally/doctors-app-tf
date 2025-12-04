resource "aws_vpc" "doctors_app_vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "doctors_app_vpc"
  }
}