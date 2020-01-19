resource "aws_dynamodb_table" "product_table" {
  name           = "Products-${var.env}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ProductId"
  range_key      = "ProductKey"

  attribute {
    name = "ProductId"
    type = "S"
  }

  attribute {
    name = "ProductKey"
    type = "S"
  }

  tags = {
    Name        = "products-table"
    Environment = var.env
  }
}

resource "aws_dynamodb_table" "products_scraper" {
  name           = "ProductScraper-${var.env}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ProductId"
  range_key      = "VendorId"

  attribute {
    name = "ProductId"
    type = "N"
  }

  attribute {
    name = "VendorId"
    type = "N"
  }

  tags = {
    Name        = "products-scraper"
    Environment = var.env
  }
}

