#security group for the application load balancer
resource "aws_security_group" "alb_security_group" {
  name        = "doctors-app-alb-sg"
  description = "enable http access on port 80"
  vpc_id      = aws_vpc.doctors_app_vpc.id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "doctors-app-alb-sg"
  }
}

#security group for the bastion host
resource "aws_security_group" "bastion_security_group" {
  name        = "doctors-app-bastion-sg"
  description = "enable ssh access on port 22"
  vpc_id      = aws_vpc.doctors_app_vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "doctors-app-bastion-sg"
  }
}

#security group for the app server
resource "aws_security_group" "app_server_security_group" {
  name        = "doctors-app-server-sg"
  description = "enable http access on port 80 via alb sg"
  vpc_id      = aws_vpc.doctors_app_vpc.id

  ingress {
    description     = "http access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "doctors-app-server-sg"
  }
}

#security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "doctors-app-database-sg"
  description = "enable mariadb access on port 3306"
  vpc_id      = aws_vpc.doctors_app_vpc.id

  ingress {
    description     = "mariadb"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_server_security_group.id]
  }

  ingress {
    description     = "custom access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "doctors-app-database-sg"
  }
}