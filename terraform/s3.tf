
# bucket name
resource "aws_s3_bucket" "files" {
  bucket = var.BucketName
}

# grabs all the files
resource "aws_s3_object" "web_files" {
  for_each = fileset("../web", "**")
  bucket   = aws_s3_bucket.files.id
  key      = each.value
  source   = "../web/${each.value}"
}
