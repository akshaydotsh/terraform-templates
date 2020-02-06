provider "aws" {
  region = var.region
  profile = var.profile
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = var.project_name
    Environment = var.project_env
  }

  lifecycle {
    create_before_destroy = true
  }
}
