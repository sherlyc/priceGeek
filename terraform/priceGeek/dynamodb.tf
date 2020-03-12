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
    type = "S"
  }

  attribute {
    name = "VendorId"
    type = "S"
  }

  tags = {
    Name        = "products-scraper"
    Environment = var.env
  }
}

resource "aws_dynamodb_table_item" "products_scraper" {
  table_name = aws_dynamodb_table.products_scraper.name
  hash_key = aws_dynamodb_table.products_scraper.hash_key

  item = <<ITEM
{
  "ProductId": {"S": "1001"},
  "VendorId": {"S": "1"}
}
ITEM
}

resource "aws_dynamodb_table" "products_history" {
  name = "ProductHistory-${var.env}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ProductId_VendorId"
  range_key      = "Timestamp"

  attribute {
    name = "ProductId_VendorId"
    type = "S"
  }

  attribute {
    name = "Timestamp"
    type = "S"
  }

  tags = {
    Name        = "products-history"
    Environment = var.env
  }
}

resource "aws_dynamodb_table" "vendors" {
  name = "Vendors-${var.env}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "VendorId"
  range_key = "ProductId"

  attribute {
    name = "VendorId"
    type = "S"
  }

  attribute {
    name = "ProductId"
    type = "S"
  }
}

