resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true
  default_root_object = "index.html"
  aliases = [var.domain]
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "www"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  origin {
    domain_name = aws_s3_bucket.www.bucket_domain_name
    origin_id = "www"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.site-access-s3.cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = var.acm_arn
    minimum_protocol_version = var.cloudfront_min_protocol_ver
    ssl_support_method = var.cloudfront_ssl_method
    cloudfront_default_certificate = var.cloudfront_default_cert
  }
}

resource "aws_cloudfront_origin_access_identity" "site-access-s3" {
  comment ="access_from_cloudfront"
}