#!/bin/bash

sudo apt update -y
sudo apt install -y apache2 php php-mysql mysql-server unzip curl

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mysql
sudo systemctl enable mysql

sudo rm -rf /var/www/html/*
sudo aws s3 cp s3://terra-bucket-cloud/ /var/www/html/ --recursive

sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

#!/bin/bash

sudo apt update -y
sudo apt install -y apache2 php php-mysql mysql-server unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mysql
sudo systemctl enable mysql

sudo rm -rf /var/www/html/*
sudo aws s3 cp s3://terra-bucket-cloud/ /var/www/html/ --recursive

sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

sudo mysql -u root <<EOF
CREATE DATABASE files_db;
DROP USER IF EXISTS 'appuser'@'localhost';
CREATE USER 'appuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'SuperSecure123!';
GRANT ALL PRIVILEGES ON files_db.* TO 'appuser'@'localhost';
FLUSH PRIVILEGES;

USE files_db;
CREATE TABLE files (
    id INT AUTO_INCREMENT PRIMARY KEY,
    filename VARCHAR(255),
    description VARCHAR(255),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF

sudo systemctl restart apache2
sudo systemctl restart mysql
sudo systemctl restart apache2
sudo systemctl restart mysql