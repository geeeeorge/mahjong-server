resource "aws_apigatewayv2_api" "websocket_gw" {
  name                       = var.gateway_name
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

resource "aws_apigatewayv2_stage" "websocket_stage" {
  api_id      = aws_apigatewayv2_api.websocket_gw.id
  name        = var.env
  auto_deploy = true
}
