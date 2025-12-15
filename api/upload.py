import boto3, os, json, base64

s3 = boto3.client("s3")
dynamodb = boto3.client("dynamodb")

BUCKET = os.environ["BUCKET_NAME"]
TABLE = os.environ["TABLE_NAME"]

def lambda_handler(event, context):
    try:
        event_body = json.loads(event["body"])
    except Exception:
        return {
            "statusCode": 400,
            "headers": {"Access-Control-Allow-Origin": "*"},
            "body": json.dumps({"error": "Invalid request body"})
        }

    filename = event_body.get("filename")
    description = event_body.get("description", "")
    content_base64 = event_body.get("content", "")

    if not filename or not content_base64:
        return {
            "statusCode": 400,
            "headers": {"Access-Control-Allow-Origin": "*"},
            "body": json.dumps({"error": "Missing filename or content"})
        }

    # decode base64 content
    content_bytes = base64.b64decode(content_base64)

    # upload to S3
    s3.put_object(Bucket=BUCKET, Key=filename, Body=content_bytes)

    # save metadata
    dynamodb.put_item(
        TableName=TABLE,
        Item={
            "filename": {"S": filename},
            "description": {"S": description}
        }
    )

    return {
        "statusCode": 200,
        "headers": {"Access-Control-Allow-Origin": "*", "Content-Type": "application/json"},
        "body": json.dumps({"message": f"{filename} uploaded!"})
    }
