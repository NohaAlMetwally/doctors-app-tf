resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.doctors_app_vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = { Name = "public_subnet_az1" }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.doctors_app_vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = { Name = "public_subnet_az2" }
}

resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id            = aws_vpc.doctors_app_vpc.id
  cidr_block        = var.private_app_subnet_az1_cidr
  availability_zone = var.az1

  tags = { Name = "private_app_subnet_az1" }
}

resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id            = aws_vpc.doctors_app_vpc.id
  cidr_block        = var.private_app_subnet_az2_cidr
  availability_zone = var.az2

  tags = { Name = "private_app_subnet_az2" }
}

resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id            = aws_vpc.doctors_app_vpc.id
  cidr_block        = var.private_data_subnet_az1_cidr
  availability_zone = var.az1

  tags = { Name = "private_data_subnet_az1" }
}

resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id            = aws_vpc.doctors_app_vpc.id
  cidr_block        = var.private_data_subnet_az2_cidr
  availability_zone = var.az2

  tags = { Name = "private_data_subnet_az2" }
}
