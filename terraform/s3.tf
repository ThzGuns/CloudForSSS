resource "aws_s3_bucket" "uploads" {
  bucket = var.BucketName
}

resource "aws_s3_object" "web_files" {
  for_each = {
    "index.html" = templatefile("${path.module}/index.html.tpl", { api_url = aws_api_gateway_deployment.api_invoke.invoke_url })
  }
    bucket = aws_s3_bucket.uploads.id
  key    = each.key
  content = each.value
  acl    = "public-read"
}