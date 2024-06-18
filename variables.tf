variable "region" {
  description = "AWS region"
  default     = "eu-west-3"
}

variable "source_bucket_name" {
  description = "The name of the source S3 bucket"
  type        = string
  default     = "source-bucket-mitiga"
}

variable "assets_bucket_name" {
  description = "The name of the assets S3 bucket"
  type        = string
  default     = "assets-bucket-mitiga"
}

# variable "s3_name" {
#   type = string
# }
