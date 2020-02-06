output "s3_origin_id" {
  value = local.s3_origin_id
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.b.bucket_regional_domain_name
}

output "bucket_id" {
  value = aws_s3_bucket.b.id
}

output "bucket_arn" {
  value = aws_s3_bucket.b.arn
}