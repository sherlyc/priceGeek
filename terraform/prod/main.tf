terraform {
  backend "s3" {
    bucket = "pricegeektfstate"
    key = "prod.json"
    region = "ap-southeast-2"
  }
}

variable "env" {
  default = "prod"
}

module "priceGeek" {
  source = "../priceGeek"
  env = var.env
}