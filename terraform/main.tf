provider "aws" {
  region = var.aws_region
}

# ── Security Group ──────────────────────────────────────────
resource "aws_security_group" "autoops_sg" {
  name        = "autoops-sg"
  description = "Allow SSH, HTTP, Jenkins, Prometheus, Grafana"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Node Exporter"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "autoops-sg"
    Project = "AutoOps"
  }
}

# ── EC2: App Server ─────────────────────────────────────────
resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.autoops_sg.id]

  tags = {
    Name    = "autoops-app-server"
    Project = "AutoOps"
    Role    = "App"
  }
}

# ── EC2: Jenkins Server ─────────────────────────────────────
resource "aws_instance" "jenkins_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.autoops_sg.id]

  tags = {
    Name    = "autoops-jenkins-server"
    Project = "AutoOps"
    Role    = "Jenkins"
  }
}

# ── EC2: Monitoring Server ──────────────────────────────────
resource "aws_instance" "monitoring_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.autoops_sg.id]

  tags = {
    Name    = "autoops-monitoring-server"
    Project = "AutoOps"
    Role    = "Monitoring"
  }
}

# ── S3 Bucket: Terraform State ──────────────────────────────
# resource "aws_s3_bucket" "terraform_state" {
#   bucket        = "autoops-terraform-state-bucket"
#   force_destroy = true

#   tags = {
#     Name    = "autoops-state"
#     Project = "AutoOps"
#   }
# }

# resource "aws_s3_bucket_versioning" "state_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }