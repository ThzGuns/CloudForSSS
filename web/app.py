from flask import Flask, request, render_template, redirect
import boto3
import json

app = Flask(__name__)
lambda_client = boto3.client('lambda', region_name='eu-west-1')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['file']
    filename = file.filename
    content = file.read().decode('utf-8') 
    payload = {
        "filename": filename,
        "description": "Uploaded via web",
        "content": content
    }

    response = lambda_client.invoke(
        FunctionName='file-upload-api',
        Payload=json.dumps(payload)
    )

    return f"File uploaded! Lambda status: {response['StatusCode']}"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
