module "s3-aws_s3_bucket_website_configuration" {
  source = "./modules/s3-bucket"
  source_bucket_name = var.source_bucket_name
  assets_bucket_name = var.assets_bucket_name
}

locals {
  s3_origin_id        = "${var.source_bucket_name}-origin"
  # s3_website_endpoint = "${aws_s3_bucket.source_bucket.bucket}.s3-website-${var.region}.amazonaws.com"
}

resource "aws_cloudfront_distribution" "website_distribution" {
  enabled = true

  origin {
    origin_id   = local.s3_origin_id
    domain_name = module.s3-aws_s3_bucket_website_configuration.source_bucket_website_endpoint

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id = local.s3_origin_id
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


resource "aws_route53_zone" "main" {
  name = "mitigasolutions.com"
}

resource "aws_route53_record" "website" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "test"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.website_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.website_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
