import boto3, os, json

s3 = boto3.client("s3")
dynamodb = boto3.client("dynamodb")

BUCKET = os.environ["BUCKET_NAME"]
TABLE = os.environ["TABLE_NAME"]

def lambda_handler(event, context):
    filename = event.get("filename")
    description = event.get("description", "")
    content = event.get("content", "")

    s3.put_object(Bucket=BUCKET, Key=filename, Body=content)

    dynamodb.put_item(
        TableName=TABLE,
        Item={
            "filename": {"S": filename},
            "description": {"S": description}
        }
    )

    return {"statusCode": 200, "body": json.dumps(f"{filename} uploaded!")}
