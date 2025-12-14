resource "aws_s3_bucket" "uploads" {
  bucket = var.BucketName
}

resource "aws_s3_object" "web_files" {
  for_each = fileset("../web", "**")  # alles in ../web
  bucket   = aws_s3_bucket.uploads.id
  key      = each.value
  source   = "../web/${each.value}"
}