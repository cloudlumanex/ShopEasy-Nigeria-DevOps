provider "aws" {
  region = var.region
}

#---------------------------------------------------
# Vpc Creation
#------------------------------------------------------

resource "aws_vpc" "shopeasy_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.shopeasy}_vpc"
  }
}

#---------------------------------------------------
# Internet gateway
#------------------------------------------------------

resource "aws_internet_gateway" "shopeasy_IGW" {
  vpc_id = aws_vpc.shopeasy_vpc.id

  tags = {
    Name = "${var.shopeasy}_igw"
  }
}

#---------------------------------------------------
# Public Subnets 
#------------------------------------------------------

resource "aws_subnet" "shopeasy_public_subnet_a" {
  vpc_id                  = aws_vpc.shopeasy_vpc.id
  cidr_block              = var.shopeasy_public_subnet_a
  map_public_ip_on_launch = true
  availability_zone = var.availability_zones[0]

    tags = {
        Name = "${var.shopeasy}-public-subnet-a"
    }
}

resource "aws_subnet" "shopeasy_public_subnet_b" {
  vpc_id                  = aws_vpc.shopeasy_vpc.id
  cidr_block              = var.shopeasy_public_subnet_b
  map_public_ip_on_launch = true
  availability_zone = var.availability_zones[1]

    tags = {
        Name = "${var.shopeasy}-public-subnet-b"
    }
}

#---------------------------------------------------
# Private Subnets for Application and Database Layers
#------------------------------------------------------

resource "aws_subnet" "shopeasy_private_subnet_a" {
  vpc_id                  = aws_vpc.shopeasy_vpc.id
  cidr_block              = var.shopeasy_private_subnet_a
  map_public_ip_on_launch = false
  availability_zone = var.availability_zones[0]
    tags = {
        Name = "${var.shopeasy}-private-subnet-a"
    }
}

resource "aws_subnet" "shopeasy_private_subnet_b" {
  vpc_id                  = aws_vpc.shopeasy_vpc.id
  cidr_block              = var.shopeasy_private_subnet_b
  map_public_ip_on_launch = false
  availability_zone = var.availability_zones[1]
    tags = {
        Name = "${var.shopeasy}-private-subnet-b"
    }
}

#---------------------------------------------------
# Route Table for Public Subnets
#------------------------------------------------------
resource "aws_route_table" "shopeasy_public_rt" {
  vpc_id = aws_vpc.shopeasy_vpc.id
  

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shopeasy_IGW.id
  }
    tags = {
        Name = "${var.shopeasy}-public-rt"
    }
}

#---------------------------------------------------
# Route Table Associations for Public Subnets
#------------------------------------------------------
resource "aws_route_table_association" "shopeasy_public_rt_assoc_a" {
  subnet_id      = aws_subnet.shopeasy_public_subnet_a.id
  route_table_id = aws_route_table.shopeasy_public_rt.id
}
resource "aws_route_table_association" "shopeasy_public_rt_assoc_b" {
  subnet_id      = aws_subnet.shopeasy_public_subnet_b.id
  route_table_id = aws_route_table.shopeasy_public_rt.id
}
