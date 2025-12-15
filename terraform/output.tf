output "ec2_public_ip" {
  description = "De publieke IP van de webserver EC2 instance"
  value       = aws_instance.web_app.public_ip
}

output "api_url" {
  description = "De basis-URL van de API Gateway"
  value       = aws_api_gateway_stage.prod.invoke_url
}
