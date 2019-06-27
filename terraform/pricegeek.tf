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
  website {
    index_document = "index.html"
  }
}

provider "aws" {
    region = "ap-southeast-2"
}
