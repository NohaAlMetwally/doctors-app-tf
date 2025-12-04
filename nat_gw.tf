resource "aws_eip" "eip_nat_az1" {
  domain = "vpc"
  tags   = { Name = "eip_nat_az1" }
}

resource "aws_nat_gateway" "nat_gw_az1_doctors_app" {
  allocation_id = aws_eip.eip_nat_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "nat_gw_az1_doctors_app"
  }

  depends_on = [aws_internet_gateway.igw_doctors_app]
}

resource "aws_eip" "eip_nat_az2" {
  domain = "vpc"
  tags   = { Name = "eip_nat_az2" }
}

resource "aws_nat_gateway" "nat_gw_az2_doctors_app" {
  allocation_id = aws_eip.eip_nat_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id

  tags = {
    Name = "nat_gw_az2_doctors_app"
  }

  depends_on = [aws_internet_gateway.igw_doctors_app]
}
