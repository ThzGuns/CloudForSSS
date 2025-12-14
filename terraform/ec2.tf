resource "aws_instance" "web_app" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu 22.04
  instance_type = "t2.micro"
  key_name      = "your-keypair"
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
    #!/bin/bash
    apt update
    apt install -y python3 python3-pip awscli
    pip3 install flask boto3

    mkdir -p /home/ubuntu/app
    cd /home/ubuntu/app

    # Download alle website bestanden van S3
    aws s3 cp s3://${BucketName}/ /home/ubuntu/app/ --recursive

    # Start Flask app op achtergrond
    nohup python3 /home/ubuntu/app/app.py &
  EOF

  tags = { Name = "web-app-instance" }
}
