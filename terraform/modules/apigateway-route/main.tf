resource "aws_apigatewayv2_integration" "gateway_integration" {
  api_id                    = var.gateway_id
  integration_type          = "AWS_PROXY"
  connection_type           = "INTERNET"
  content_handling_strategy = "CONVERT_TO_TEXT"
  integration_method        = "POST"
  integration_uri           = var.invoke_arn
  passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "gateway_route" {
  api_id    = var.gateway_id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.gateway_integration.id}"
}
