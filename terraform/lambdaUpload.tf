resource "aws_lambda_function" "upload" {
  function_name = "file-upload-api"
  handler       = "upload.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_role.arn
  filename      = "../api/upload.zip"
  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.uploads.bucket
      TABLE_NAME  = aws_dynamodb_table.files.name
    }
  }
}
