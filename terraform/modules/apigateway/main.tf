resource "aws_apigatewayv2_api" "websocket_gw" {
  name                       = var.gateway_name
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

resource "aws_apigatewayv2_stage" "websocket_stage" {
  api_id      = aws_apigatewayv2_api.websocket_gw.id
  name        = var.env
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigateway_access_log.arn
    format = jsonencode({
      "aws_endpoint_request_id" : "$context.awsEndpointRequestId",
      "request_id" : "$context.requestId",
      "ip" : "$context.identity.sourceIp",
      "request_time" : "$context.requestTime",
      "http_method" : "$context.httpMethod",
      "resource_path" : "$context.resourcePath",
      "status" : "$context.status",
      "protocol" : "$context.protocol",
      "response_length" : "$context.responseLength",
      "stage" : "$context.stage",
      "message" : "$context.error.message",
      "extended_request_id" : "$context.extendedRequestId",
      "validation_error_string" : "$context.error.validationErrorString",
      "integration_status" : "$context.integration.status",
      "integration_error" : "$context.integration.error",
    })
  }
}

resource "aws_cloudwatch_log_group" "apigateway_access_log" {
  name              = "/aws/apigateway/${var.gateway_name}_${var.env}_access_log"
  retention_in_days = 30
}
