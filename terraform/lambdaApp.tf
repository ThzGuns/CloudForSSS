resource "aws_lambda_function" "app" {
  function_name = "file-list-app"
  handler       = "app.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_role.arn
  filename      = "../app/app.zip"
  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.uploads.bucket
      TABLE_NAME  = aws_dynamodb_table.files.name
    }
  }
}
