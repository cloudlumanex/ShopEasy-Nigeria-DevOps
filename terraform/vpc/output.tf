output "vpc_id" {
  value = aws_vpc.shopeasy_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.shopeasy_vpc.cidr_block
}

output "public_subnets" {
  value = [aws_subnet.shopeasy_public_subnet_a.cidr_block, 
           aws_subnet.shopeasy_public_subnet_b.cidr_block
  ]   

}

output "private_subnets" {
  value = [aws_subnet.shopeasy_private_subnet_a.cidr_block, 
           aws_subnet.shopeasy_private_subnet_b.cidr_block
  ]   

}