data "archive_file" "init" {
  type        = "zip"
  source_dir = "../../dist/server/webScraper"
  output_path = "../../dist/server/webScraper.zip"
}

resource "aws_lambda_function" "webScraper" {
  function_name = "webScraper-${var.env}"
  filename = data.archive_file.init.output_path
  handler = "index.handler"
  role = aws_iam_role.webScraperRole.arn
  runtime = "nodejs10.x"
  timeout = 30
}

resource "aws_cloudwatch_event_rule" "every_twelve_hours" {
  name = "every-twelve-hours"
  description = "Fires every 12 hours"
  schedule_expression = "rate(12 hours)"
}

resource "aws_cloudwatch_event_target" "webScraper_every_twelve_hours" {
  rule = aws_cloudwatch_event_rule.every_twelve_hours.name
  target_id = "webScraper"
  arn = aws_lambda_function.webScraper.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_webScraper" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.webScraper.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.every_twelve_hours.arn
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