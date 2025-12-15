Steps for Repository:

- Terraform creates S3 bucket and uploads all files from ../web folder.
- EC2 instance launches with IAM role → can read S3.
- user_data.sh automatically installs Apache/PHP, pulls site from S3, and starts serving it.
- Visit the instance public IP to see your app/API working.