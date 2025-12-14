resource "aws_dynamodb_table" "files" {
  name         = var.TableName
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "filename"

  attribute {
    name = "filename"
    type = "S"
  }

}
