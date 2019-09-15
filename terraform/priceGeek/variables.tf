variable "env" {
  type = string
}

variable "cloudfront_aliases" {
  type = string
}

variable "acm_arn" {
  type = string
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

