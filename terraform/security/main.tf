#----------------------------------------------------
# Security Group for ShopEasy Application Load Balancer
#----------------------------------------------------

resource "aws_security_group" "shopeasy_alb_sg" {
  name = "${var.project_name}-alb-sg"
  description = "Allow HTTP and HTTPS traffic the internet"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "Allow HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  description = "Allow HTTPS from the internet"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }


  egress {
    
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]   
}
tags =  {
    Name = "${var.project_name}-alb-sg"
  }
}
#----------------------------------------------------
# Security Group for ShopEasy Application Servers
#----------------------------------------------------

resource "aws_security_group" "shopeasy_app_sg" {
  name = "${var.project_name}-app-sg"
  description = "Allow traffic from ALB to only"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "Allow HTTP from ALB"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    security_groups = [aws_security_group.shopeasy_alb_sg.id]
  }

  egress {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  
}
tags =  {
    Name = "${var.project_name}-app-sg"
  }
}

#----------------------------------------------------
# Security Group for ShopEasy Application Database
#----------------------------------------------------
resource "aws_security_group" "shopeasy_db_sg" {
  name = "${var.project_name}-db-sg"
  description = "Allow traffic from App Servers to DB only"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id


  ingress {
    description = "Allow Postgres from App Servers"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.shopeasy_app_sg.id]
  }

  egress {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]  
}
tags =  {
    Name = "${var.project_name}-db-sg"
  }
}

resource "aws_iam_role" "shopeasy_cicd_role" {
    name = "${var.project_name}-cicd-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "shopeasy_cicd_policy" {
    name = "${var.project_name}-cicd-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "ec2:*",
          "codepipeline:*",
          "codebuild:*",
          "codedeploy:*",
          "iam:*",
          "cloudwatch:*",
          "logs:*",
          "autoscaling:*",
          "elasticloadbalancing:*",
          "rds:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "shopeasy_cicd_role_attachment" {
  role       = aws_iam_role.shopeasy_cicd_role.name
  policy_arn = aws_iam_policy.shopeasy_cicd_policy.arn
}