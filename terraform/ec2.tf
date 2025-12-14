resource "aws_instance" "web_app" {
  ami           = "ami-09c54d172e7aa3d9a"
  instance_type = "t3.micro"
  key_name      = "KeyMaterial"

  security_groups = [aws_security_group.web_sg.name]

  user_data = file("user_data.sh") # script to install web server + APP files

  tags = {
    Name = "AppServer"
  }
}