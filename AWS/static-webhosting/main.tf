provider "aws" {
  region = var.region
  profile = var.profile
}

module "s3" {
  source = "./s3"
  bucket_name = var.bucket_name
}

module "cdn" {
  source = "./cloudfront"
  acm_certificate_arn = var.acm_certificate_arn
  domain_name = var.domain_name
  bucket_arn = module.s3.bucket_arn
  bucket_id = module.s3.bucket_id
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  s3_origin_id = module.s3.s3_origin_id
}