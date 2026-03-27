variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  # Amazon Linux 2 AMI (Free Tier) — us-east-1
  default = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Your AWS EC2 Key Pair name"
  default     = "autoops-key"
}