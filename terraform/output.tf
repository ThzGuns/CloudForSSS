output "ec2_public_ip" {
  value = aws_instance.web_app.public_ip
}

output "bucket_name" {
  value = aws_s3_bucket.files.bucket
}
