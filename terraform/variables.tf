variable "AwsRegion" { 
    default = "eu-west-1" 
}
variable "BucketName" { 
    default = "terra-bucket-cloud" 
}
variable "TableName" { 
    default = "files-metadata"
}
variable "EC2KeyName" {
  default = "KeyMaterial"
}
variable "ami" {
  type        = string
  default     = "ami-049442a6cf8319180" 
}

variable "db_user" {
  type    = string
  default = "admin"
}

variable "db_pass" {
  type    = string
  default = "SuperSecure123!"
}
