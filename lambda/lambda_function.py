# lambda_function.py
import json
import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    for record in event['Records']:
        payload = base64.b64decode(record["kinesis"]["data"])
        s3.put_object(Bucket='your-bucket-name', Key='key.json', Body=payload)
    return {"statusCode": 200}
