resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true
  default_root_object = "index.html"
  aliases = ["${var.domain_prefix}.priceninja.io"]
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
    acm_certificate_arn ="arn:aws:acm:us-east-1:201687515750:certificate/64a3206b-fe4f-4c1e-a857-cab4ebd4404a"
    minimum_protocol_version = "TLSv1"
    ssl_support_method = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "site-access-s3" {
  comment ="access_from_cloudfront"
}