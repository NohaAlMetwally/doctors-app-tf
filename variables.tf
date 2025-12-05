variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_az1_cidr" {
  type = string
}

variable "public_subnet_az2_cidr" {
  type = string
}

variable "private_app_subnet_az1_cidr" {
  type = string
}

variable "private_app_subnet_az2_cidr" {
  type = string
}
variable "private_data_subnet_az1_cidr" {
  type = string
}

variable "private_data_subnet_az2_cidr" {
  type = string
}
variable "az2" {
  type = string
}

variable "az1" {
  type = string
}

#variable "db_password" {
#  type      = string
#  sensitive = true
#}

#variable "db_username" {
#  type = string
#}

variable "db_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_type" {
  type = string
}

variable "bastion_public_key_path" {
  type = string
}

variable "container_image" {
  description = "Container image to use for the web container (including tag)"
  type        = string
  default     = "nohaalmetwally/doctor-appointment-app:latest"
}