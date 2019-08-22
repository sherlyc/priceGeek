terraform {
  required_version = "~> 0.12"

  backend "s3" {
    encrypt = true
  }


}

provider "aws" {
  region = "ap-southeast-2"
}

data "aws_iam_policy_document" "site_policy_data" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"]
    resources = [
      "${aws_s3_bucket.www.arn}/*"]

    principals {
      identifiers = [
        aws_cloudfront_origin_access_identity.site-access-s3.iam_arn
      ]
      type = "AWS"
    }
  }
}





