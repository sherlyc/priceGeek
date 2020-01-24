data "archive_file" "init" {
  type        = "zip"
  source_dir = "../../dist/server/webScraper"
  output_path = "../../dist/server/webScraper.zip"
}

resource "aws_lambda_function" "webScraper" {
  function_name = "webScraper-${var.env}"
  filename = data.archive_file.init.output_path
  handler = "index.handler"
  source_code_hash = filebase64sha256(data.archive_file.init.output_path)
  role = aws_iam_role.webScraperRole.arn
  runtime = "nodejs10.x"
  timeout = 30
  environment {
    variables = {
      environment = var.env
    }
  }
}

resource "aws_iam_role" "webScraperRole" {
  name = "webScraperRole-${var.env}"
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

resource "aws_iam_role_policy_attachment" "lambdaBasicExecution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.webScraperRole.name
}
