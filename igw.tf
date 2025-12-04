resource "aws_internet_gateway" "igw_doctors_app" {
  vpc_id = aws_vpc.doctors_app_vpc.id

  tags = {
    Name = "igw_doctors_app"
  }
}