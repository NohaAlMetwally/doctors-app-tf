output "vpc_id" {
  value = aws_vpc.doctors_app_vpc.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}
output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

output "private_app_subnet_az1_id" {
  value = aws_subnet.private_app_subnet_az1.id
}
output "private_app_subnet_az2_id" {
  value = aws_subnet.private_app_subnet_az2.id
}

output "private_data_subnet_az1_id" {
  value = aws_subnet.private_data_subnet_az1.id
}

output "private_data_subnet_az2_id" {
  value = aws_subnet.private_data_subnet_az2.id
}
output "alb_dns" {
  value = aws_lb.application_load_balancer.dns_name
}
output "db_host" {
  description = "RDS endpoint for the application"
  value       = aws_db_instance.mariadb.address
}


output "db_name" {
  description = "Database name"
  value       = var.db_name
}

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}