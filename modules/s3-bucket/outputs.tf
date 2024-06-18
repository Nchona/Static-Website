output "source_bucket_id" {
  value = aws_s3_bucket.source_bucket.id
}

output "source_bucket_website_endpoint" {
  value = aws_s3_bucket.source_bucket.website_endpoint
}

output "assets_bucket_id" {
  value = aws_s3_bucket.assets_bucket.id
}
