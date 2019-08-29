resource "aws_s3_bucket" "www" {
  bucket = "${var.env}-pricegeekwww"
  acl = "private"
  tags = {
    terraform="true"
  }

}

resource "aws_s3_bucket_policy" "site_policy" {
  bucket = aws_s3_bucket.www.bucket
  policy = data.aws_iam_policy_document.site_policy_data.json
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.www.bucket
  key = "index.html"
  source = "../../src/client/index.html"
  content_type = "text/html"
  etag = "${md5(file("../../src/client/index.html"))}"
}