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