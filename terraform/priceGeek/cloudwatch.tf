resource "aws_cloudwatch_event_rule" "twentyfour_hours_webscraper" {
  name = "twentyfour-hours-webscraper-${var.env}"
  description = "Fires every 24 hours"
  schedule_expression = "rate(24 hours)"
}

resource "aws_cloudwatch_event_target" "webscraper_twentyfour_hours" {
  rule = aws_cloudwatch_event_rule.twentyfour_hours_webscraper.name
  target_id = "webScraper"
  arn = aws_lambda_function.webScraper.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_webscraper" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.webScraper.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.twentyfour_hours_webscraper.arn
}
