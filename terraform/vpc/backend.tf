terraform {
  backend "s3" {
    bucket         = "lumanex-terraform-state"
    key            = "vpc/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "lumanex-terraform-lock" # Optional: For state locking
  }
}
