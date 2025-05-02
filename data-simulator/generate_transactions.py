import json
import random
import time
from datetime import datetime
import uuid
import boto3

# AWS Kinesis client setup
kinesis_client = boto3.client('kinesis', region_name='us-east-2')  # Use the region of your stream
stream_name = 'retail-transactions-stream'  # Make sure this matches your stream name exactly

# Sample product catalog
products = [
    {"id": 1, "name": "T-shirt", "price": 20},
    {"id": 2, "name": "Jeans", "price": 50},
    {"id": 3, "name": "Sneakers", "price": 70},
    {"id": 4, "name": "Jacket", "price": 100},
    {"id": 5, "name": "Socks", "price": 5},
]

# Simulate 10 transactions
for _ in range(50):
    product = random.choice(products)
    transaction = {
        "transaction_id": str(uuid.uuid4()),
        "timestamp": datetime.utcnow().isoformat(),
        "product_id": product["id"],
        "product_name": product["name"],
        "price": product["price"],
        "quantity": random.randint(1, 5),
        "total_amount": 0
    }
    transaction["total_amount"] = transaction["price"] * transaction["quantity"]
    data = json.dumps(transaction)

    # Send to Kinesis
    response = kinesis_client.put_record(
        StreamName=stream_name,
        Data=data,
        PartitionKey=str(transaction["product_id"])
    )

    print(f"✅ Sent to Kinesis: {data}")
    time.sleep(1)
