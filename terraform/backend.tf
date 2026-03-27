terraform {
  backend "s3" {
    bucket = "autoops-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}