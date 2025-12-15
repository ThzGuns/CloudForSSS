#!/bin/bash

sudo apt update -y
sudo apt install -y apache2 unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo systemctl start apache2
sudo systemctl enable apache2

sudo rm /var/www/html/index.html
sudo aws s3 cp s3://terra-bucket-cloud/ /var/www/html/ --recursive

sudo sed -i "s|\${api_url}|${api_url}|" /var/www/html/index.html


sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

sudo systemctl restart apache2