resource "aws_route_table" "public" {
  vpc_id = aws_vpc.doctors_app_vpc.id

  tags = { Name = "public-rt" }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_doctors_app.id
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public.id
}

# Create two private route tables (one per AZ)

resource "aws_route_table" "private_az1" {
  vpc_id = aws_vpc.doctors_app_vpc.id
  tags = { Name = "private-rt-az1" }
}

resource "aws_route" "private_route_az1" {
  route_table_id         = aws_route_table.private_az1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_az1_doctors_app.id
}

resource "aws_route_table" "private_az2" {
  vpc_id = aws_vpc.doctors_app_vpc.id
  tags = { Name = "private-rt-az2" }
}

resource "aws_route" "private_route_az2" {
  route_table_id         = aws_route_table.private_az2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_az2_doctors_app.id
}

# Associate AZ1 private subnets to private_az1
resource "aws_route_table_association" "private_app_1" {
  subnet_id      = aws_subnet.private_app_subnet_az1.id
  route_table_id = aws_route_table.private_az1.id
}

resource "aws_route_table_association" "private_data_1" {
  subnet_id      = aws_subnet.private_data_subnet_az1.id
  route_table_id = aws_route_table.private_az1.id
}

# Associate AZ2 private subnets to private_az2
resource "aws_route_table_association" "private_app_2" {
  subnet_id      = aws_subnet.private_app_subnet_az2.id
  route_table_id = aws_route_table.private_az2.id
}

resource "aws_route_table_association" "private_data_2" {
  subnet_id      = aws_subnet.private_data_subnet_az2.id
  route_table_id = aws_route_table.private_az2.id
}