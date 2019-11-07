resource "aws_route53_record" "priceninja" {
  name = var.domain_prefix
  type = "A"
  zone_id = "ZT1PPIET46X77"

  alias {
    name = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
