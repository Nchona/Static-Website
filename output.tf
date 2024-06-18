output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.website_distribution.domain_name
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.website_distribution.id
}

output "route53_alias_domain_name" {
  value = aws_cloudfront_distribution.website_distribution.domain_name
}

output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "source_bucket_id" {
  value = module.s3-aws_s3_bucket_website_configuration.source_bucket_id
}

output "source_bucket_website_endpoint" {
  value = module.s3-aws_s3_bucket_website_configuration.source_bucket_website_endpoint
}
