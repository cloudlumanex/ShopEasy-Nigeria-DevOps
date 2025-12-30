variable "shopeasy" {
  description = "Project Name"
  default     = "shopeasy_nigeria"
}

variable "region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "50.0.0.0/16"
}

variable "shopeasy_public_subnet_a" {
  description = "CIDR block for the public subnet_a"
  default     = "50.0.1.0/24"
}

variable "shopeasy_public_subnet_b" {
  description = "CIDR block for the public subnet_b"
  default     = "50.0.2.0/24"
}

variable "shopeasy_private_subnet_a" {
  description = "CIDR block for the private subnet_a"
  default     = "50.0.3.0/24"
}

variable "shopeasy_private_subnet_b" {
  description = "CIDR block for the private subnet_b"
  default     = "50.0.4.0/24"
}

variable "availability_zones" {
  description = "List of availability zones where resources will be deployed."
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b" ]
}


