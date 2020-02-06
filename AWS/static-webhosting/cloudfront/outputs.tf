output "url" {
  value = "CND is created at: ${aws_cloudfront_distribution.cdn.domain_name}"
}