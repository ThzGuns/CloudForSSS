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

