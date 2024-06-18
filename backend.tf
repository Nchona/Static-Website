terraform {
  backend "s3" {
    bucket = "tf.backend-test"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}