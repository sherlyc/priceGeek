terraform {
  backend "s3" {
    bucket = "pricegeektfstate"
    key = "dev.json"
    region = "ap-southeast-2"
  }
}

variable "env" {
  default = "dev"
}

module "priceGeek" {
  source = "../priceGeek"
  env = var.env
}