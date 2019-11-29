resource "aws_cloudwatch_event_rule" "every_twelve_hours_webScraper" {
  name = "every-twelve-hours-webScraper"
  description = "Fires every 12 hours"
  schedule_expression = "rate(12 hours)"
}

resource "aws_cloudwatch_event_target" "webScraper_every_twelve_hours" {
  rule = aws_cloudwatch_event_rule.every_twelve_hours_webScraper.name
  target_id = "webScraper"
  arn = aws_lambda_function.webScraper.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_webScraper" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.webScraper.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.every_twelve_hours_webScraper.arn
}