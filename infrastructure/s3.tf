resource "aws_s3_bucket" "bucket_cloudfront" {
  bucket = "mys3bucketforwallpapers"

  tags = {
    name = "Bucket for cloudfront"
  }

}

resource "aws_s3_bucket_acl" "public_acl" {
  bucket = aws_s3_bucket.bucket_cloudfront.id
  acl    = "private"

}

resource "aws_s3_bucket_website_configuration" "website_bucket" {
  bucket = aws_s3_bucket.bucket_cloudfront.bucket

  index_document {
    suffix = "index.html"
  }
}

locals {
  s3_origin_id = "myS3Origin"
}