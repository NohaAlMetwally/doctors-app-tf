resource "aws_db_subnet_group" "rds_subnets" {
  name = "doctors-app-db-subnet"
  subnet_ids = [
    aws_subnet.private_data_subnet_az1.id,
    aws_subnet.private_data_subnet_az2.id
  ]

  tags = {
    Name = "doctors-app-db-subnet"
  }
}

resource "aws_db_instance" "mariadb" {
  identifier             = "doctors-app-mariadb"
  engine                 = "mariadb"
  engine_version         = "10.5"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = var.db_name
  username               = local.db_creds.db_username
  password               = local.db_creds.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnets.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
   # enable standby (Multi-AZ)
  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = false
  apply_immediately      = true

  tags = {
    Name = "doctors-app-mariadb"
  }
}


