output "vpc_id" {
  value = aws_vpc.shopeasy_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.shopeasy_vpc.cidr_block
}

# -------------------------
# Public Subnet IDs
# -------------------------
output "public_subnet_a_id" {
  value = aws_subnet.shopeasy_public_subnet_a.id
}

output "public_subnet_b_id" {
  value = aws_subnet.shopeasy_public_subnet_b.id
}

output "public_subnets" {
  value = [
    aws_subnet.shopeasy_public_subnet_a.id,
    aws_subnet.shopeasy_public_subnet_b.id
  ]
}

# -------------------------
# Private Subnet IDs
# -------------------------
output "private_subnet_a_id" {
  value = aws_subnet.shopeasy_private_subnet_a.id
}

output "private_subnet_b_id" {
  value = aws_subnet.shopeasy_private_subnet_b.id
}

output "private_subnets" {
  value = [
    aws_subnet.shopeasy_private_subnet_a.id,
    aws_subnet.shopeasy_private_subnet_b.id
  ]
}
