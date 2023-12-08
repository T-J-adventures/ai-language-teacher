#IAM role_____________________________________
resource "aws_iam_role" "lambda_role" {
  name               = "${var.lambda_prefix}_Lambda_Function_Role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_policy" "lambda_iam_policy" {
  name        = "${var.lambda_prefix}_Lambda_Iam_policy"
  path        = "/"
  description = "AWS IAM Policy for hello lambda function"
  policy      = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_iam_policy.arn
}
#END IAM role_____________________________________

#Lambda_____________________________________
resource "aws_lambda_function" "lambda_deploy" {
  filename      = var.lambda_file_path
  function_name = "${var.lambda_prefix}_Lambda_Function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"

  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_role]
}
#END Lambda_____________________________________

#Gateway_____________________________________
resource "aws_api_gateway_rest_api" "lambda_rest_api" {
  name        = "${var.lambda_prefix}_Lambda_Rest_Api"
  description = "${var.lambda_prefix}__Lambda_Rest_Api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "lambda_rest_api_root" {
  rest_api_id = aws_api_gateway_rest_api.lambda_rest_api.id
  parent_id   = aws_api_gateway_rest_api.lambda_rest_api.root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_method" "lambda_rest_api_method" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_rest_api.id
  resource_id   = aws_api_gateway_resource.lambda_rest_api_root.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.lambda_rest_api.id
  resource_id             = aws_api_gateway_resource.lambda_rest_api_root.id
  http_method             = aws_api_gateway_method.lambda_rest_api_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_deploy.invoke_arn
}

resource "aws_api_gateway_deployment" "lambda_api_deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.lambda_rest_api.id}"
  stage_name  = "test"

  depends_on = [aws_api_gateway_integration.lambda_api_integration]
}

resource "aws_lambda_permission" "lambda_api_run_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_deploy.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.lambda_rest_api.execution_arn}/*/*"
}
#END Gateway_____________________________________
