locals {
  s3_origin_id        = "${var.source_bucket_name}-origin"
  s3_website_endpoint = "${aws_s3_bucket.source_bucket.bucket}.s3-website-${var.region}.amazonaws.com"
}

resource "aws_s3_bucket" "source_bucket" {
  bucket = var.source_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    noncurrent_version_expiration {
      days = 30
    }
    abort_incomplete_multipart_upload_days = 7

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Allows CloudFront to reach the S3 bucket"
}

resource "aws_s3_bucket_policy" "source_bucket_policy" {
  bucket = aws_s3_bucket.source_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.source_bucket.bucket}/*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "assets_bucket" {
  bucket = var.assets_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    noncurrent_version_expiration {
      days = 30
    }
    abort_incomplete_multipart_upload_days = 7

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_object" "source_dummy_objects" {
  count   = 3
  bucket  = aws_s3_bucket.source_bucket.bucket
  key     = "source_dummy_object_${count.index}.txt"
  content = "This is a dummy object ${count.index} in source bucket."
}

resource "aws_s3_bucket_object" "assets_dummy_objects" {
  count   = 3
  bucket  = aws_s3_bucket.assets_bucket.bucket
  key     = "assets_dummy_object_${count.index}.txt"
  content = "This is a dummy object ${count.index} in assets bucket."
}

resource "aws_s3_bucket_object" "website_files" {
  bucket  = aws_s3_bucket.source_bucket.bucket
  key     = "index.html"
  content = "<html><body><h1>Welcome to the test.mitigasolutions.com website</h1></body></html>"
}

resource "aws_s3_bucket_object" "error_page" {
  bucket  = aws_s3_bucket.source_bucket.bucket
  key     = "error.html"
  content = "<html><body><h1>Error: Page not found</h1></body></html>"
}
