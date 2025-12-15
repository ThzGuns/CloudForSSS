data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "web_app" {
  ami                    = "ami-09c54d172e7aa3d9a"
  instance_type           = "t3.micro"
  key_name                = "KeyMaterial"

  vpc_security_group_ids  = [aws_security_group.web_sg.id]
  iam_instance_profile    = aws_iam_instance_profile.ec2_s3_profile.name

  user_data                   = file("user_data.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "AppServer"
  }
}


resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP"
  vpc_id      = data.aws_vpc.default.id

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
