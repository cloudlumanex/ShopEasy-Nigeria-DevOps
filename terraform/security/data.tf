data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "lumanex-terraform-state"
    key    = "vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}
