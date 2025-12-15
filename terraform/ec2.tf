resource "aws_instance" "web_app" {
  ami             = "ami-09c54d172e7aa3d9a"
  instance_type   = "t3.micro"
  key_name        = "KeyMaterial"
  security_groups = [aws_security_group.web_sg.name]

  # ADD THIS LINE
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name

  user_data               = file("user_data.sh")
  user_data_replace_on_change = true  # Recommended

  tags = {
    Name = "AppServer"
  }
}