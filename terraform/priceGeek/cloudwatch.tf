resource "aws_cloudwatch_event_rule" "twelve_hours_webscraper" {
  name = "twelve-hours-webscraper-${var.env}"
  description = "Fires every 12 hours"
  schedule_expression = "rate(12 hours)"
}

resource "aws_cloudwatch_event_target" "webscraper_twelve_hours" {
  rule = "aws_cloudwatch_event_rule.every_twelve_hours_webscraper_${var.env}.name"
  target_id = "webScraper"
  arn = "aws_lambda_function.webscraper_${var.env}.arn"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_webscraper" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.webScraper.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.twelve_hours_webscraper.arn
}