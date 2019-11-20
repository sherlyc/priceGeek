data "archive_file" "init" {
  type        = "zip"
  source_dir = "../../dist/server/lambda1"
  output_path = "../../dist/server/lambda1/file.zip"
}

resource "aws_lambda_function" "lambda1" {
  function_name = "lambda1-${var.env}"
  filename = data.archive_file.init.output_path
  handler = "index.handler"
  role = aws_iam_role.webScraperRole.arn
  runtime = "nodejs10.x"
}

resource "aws_iam_role" "lambda1Role" {
  name = "lambda1Role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.lambdaPolicy.json
}

data "aws_iam_policy_document" "lambdaPolicy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type = "Service"
    }
  }
}