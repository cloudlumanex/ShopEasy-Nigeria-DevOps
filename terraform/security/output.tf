output "shopeasy_alb_sg_id" {
  value = aws_security_group.shopeasy_alb_sg.id
}

output "shopeasy_app_sg_id" {
  value = aws_security_group.shopeasy_app_sg.id
}   

output "shopeasy_db_sg_id" {
  value = aws_security_group.shopeasy_db_sg.id
}

output "shopeasy_cicd_role_id" {
  value = aws_iam_role.shopeasy_cicd_role.arn
}