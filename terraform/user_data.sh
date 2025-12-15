#!/bin/bash

apt update -y
apt install -y apache2 php libapache2-mod-php php-mysql awscli unzip

systemctl start apache2
systemctl enable apache2

aws s3 cp s3://${var.BucketName}/ /var/www/html/ --recursive

chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

systemctl restart apache2