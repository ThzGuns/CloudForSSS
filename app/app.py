import boto3, os, json

s3 = boto3.client("s3")
dynamodb = boto3.client("dynamodb")

BUCKET = os.environ["BUCKET_NAME"]
TABLE = os.environ["TABLE_NAME"]

def lambda_handler(event, context):
    items = dynamodb.scan(TableName=TABLE)["Items"]
    files = [{"filename": i["filename"]["S"], "description": i["description"]["S"]} for i in items]
    
    # Optionally generate presigned download links
    for f in files:
        f["download_url"] = s3.generate_presigned_url(
            'get_object', Params={'Bucket': BUCKET, 'Key': f["filename"]}, ExpiresIn=3600
        )

    return {"statusCode": 200, "body": json.dumps(files)}
