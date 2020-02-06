provider "aws" {
  region = var.region
  profile = var.profile
}

module "vpc" {
  source = "./vpc"
  availability_zones = var.availability_zones
  ipv4_everywhere = var.ipv4_everywhere
  private_cidrs = var.private_cidrs
  public_cidrs = var.public_cidrs
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

module "fargate" {
  source = "./fargate"
  app_port = var.app_port
  container_name = var.container_name
  desired_count = var.desired_count
  fargate_cpu = var.fargate_cpu
  fargate_memory = var.fargate_memory
  image_url = var.image_url
  private_sg = module.vpc.private_sg
  private_subnets = module.vpc.private_subnets
  public_sg = module.vpc.public_sg
  public_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
}