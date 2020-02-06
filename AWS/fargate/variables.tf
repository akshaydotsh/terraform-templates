variable "region" {}
variable "profile" {}

variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_cidrs" { type = list(string)}
variable "availability_zones" {}
variable "private_cidrs" { type = list(string) }
variable "ipv4_everywhere" {}

variable "app_port" {}
variable "container_name" {}
variable "desired_count" {}
variable "fargate_cpu" {}
variable "fargate_memory" {}
variable "image_url" {}
