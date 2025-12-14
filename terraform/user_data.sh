#!/bin/bash
yum update -y
yum install -y httpd php
systemctl start httpd
systemctl enable httpd

# Download je sitebestanden van S3
aws s3 cp s3://terra-bucket-cloud/web /var/www/html/ --recursive

# Optioneel: juiste permissies
chown -R apache:apache /var/www/html/
chmod -R 755 /var/www/html/
