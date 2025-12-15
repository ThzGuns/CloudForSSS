resource "aws_instance" "web_app" {
  ami           = var.ami
  instance_type = "t3.micro"
  key_name      = var.EC2KeyName

  subnet_id = data.aws_subnets.default_subnets.ids[0]

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile  = aws_iam_instance_profile.ec2_profile.name

  user_data = templatefile("${path.module}/user_data.sh", {
    bucket_name = aws_s3_bucket.files.bucket
  })

  tags = {
    Name = "PHP-App-Server"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = data.aws_vpc.default_vpc.id

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
