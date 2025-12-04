resource "aws_key_pair" "bastion_key" {
  key_name   = "doctor-app-bastion-key"
  public_key = file(var.bastion_public_key_path)
}

resource "aws_instance" "bastion" {
  ami                         = var.ami_type
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_az1.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.bastion_key.key_name
  vpc_security_group_ids      = [aws_security_group.bastion_security_group.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y mariadb-client
              EOF

  tags = {
    Name = "doctors-app-bastion"
  }
}