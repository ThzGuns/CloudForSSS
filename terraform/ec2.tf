data "aws_vpc" "default" {
  default = true
}
resource "aws_instance" "web_app" {
  ami                    = "ami-049442a6cf8319180"
  instance_type           = "t3.micro"
  key_name                = "KeyMaterial"
  vpc_security_group_ids  = [aws_security_group.web_sg.id]
  iam_instance_profile    = aws_iam_instance_profile.ec2_profile.name

  user_data = templatefile("${path.module}/user_data.sh", {
    bucket_name = var.BucketName,
    api_url = aws_api_gateway_stage.prod.invoke_url
    depends_on = [aws_api_gateway_stage.prod]

  })

  tags = {
    Name = "AppServer"
  }
}



resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  description = "Allow HTTP"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
