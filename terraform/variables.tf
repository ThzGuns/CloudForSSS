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

variable "AWSAccessKey" {
  default = ""  # leave empty in code
}

variable "AWSSecretKey" {
  default = ""
}