terraform {
    backend "s3" {
        bucket = "pricegeektfstate"
        key = "test.json"
        region = "ap-southeast-2"
    }
}

resource "aws_s3_bucket" "www" {
  bucket = "pricegeekwww"
  acl = "private"
  tags = {
    terraform="true"
    }

}


resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = false
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "www"
    viewer_protocol_policy = "allow-all"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  origin {
    domain_name = aws_s3_bucket.www.bucket_regional_domain_name
    origin_id = "www"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {}
}
provider "aws" {
    region = "ap-southeast-2"
}
