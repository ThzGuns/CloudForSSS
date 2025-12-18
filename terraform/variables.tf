
variable "AwsRegion" { 
    default = "eu-west-1" 
}

variable "BucketName" { 
    default = "terra-bucket-cloud" #<-- create a unique one 
}

variable "EC2KeyName" {
  default = "KeyMaterial"
}

variable "ami" {
  type        = string
  default     = "ami-049442a6cf8319180" 
}

