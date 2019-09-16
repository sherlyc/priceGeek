variable "env" {
  type = string
}

variable "cloudfront_aliases" {
  type = list(string)
  default = [""]
}

variable "acm_arn" {
  type = string
  default = null
}

variable "cloudfront_default_cert" {
  type = bool
}

variable "cloudfront_min_protocol_ver" {
  type = string
}

variable "cloudfront_ssl_method" {
  type = string
}

