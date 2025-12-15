# ==================== REST API ====================
resource "aws_api_gateway_rest_api" "api" {
  name = "file-api"
}

# ==================== UPLOAD ====================
resource "aws_api_gateway_resource" "upload" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "upload"
}

resource "aws_api_gateway_method" "upload_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.upload.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "upload_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.upload.id
  http_method             = aws_api_gateway_method.upload_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.upload.invoke_arn
}

resource "aws_lambda_permission" "allow_apigw_upload" {
  statement_id  = "AllowAPIGatewayInvokeUpload"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.upload.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/POST/upload"
}

# ==================== FILES ====================
resource "aws_api_gateway_resource" "files" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "files"
}

resource "aws_api_gateway_method" "files_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.files.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "files_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.files.id
  http_method             = aws_api_gateway_method.files_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.app.invoke_arn
}

resource "aws_lambda_permission" "allow_apigw_files" {
  statement_id  = "AllowAPIGatewayInvokeFiles"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.app.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/GET/files"
}

# ==================== DEPLOYMENT ====================
resource "aws_api_gateway_deployment" "api_invoke" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  depends_on = [
    aws_api_gateway_integration.upload_lambda,
    aws_api_gateway_integration.files_lambda
  ]
}

# ==================== STAGE ====================
resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.api_invoke.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "prod"
}
