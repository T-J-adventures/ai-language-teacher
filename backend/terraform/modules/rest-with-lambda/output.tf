output "lambda_url" {
  description = "The url of the created lambda"
  value = "${aws_api_gateway_deployment.lambda_api_deployment.invoke_url}"
}
