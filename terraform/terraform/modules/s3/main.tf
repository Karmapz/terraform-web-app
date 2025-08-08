resource "aws_s3_bucket" "screenshots" {
  bucket = "my-terraform-screenshots-${random_string.bucket_suffix.result}"
  tags = {
    Name = "terraform-screenshots"
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
}
