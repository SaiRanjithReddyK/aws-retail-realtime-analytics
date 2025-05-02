#  AWS Retail Real-Time Analytics Pipeline

A real-time data pipeline built with **AWS Kinesis**, **AWS Lambda**, **S3**, **Athena**, and **QuickSight**, simulating and analyzing **70+ retail transactions**. This project demonstrates how to stream, store, query, and visualize transactional data using fully managed AWS services, along with **Python** for simulation and Lambda logic, and **SQL** for analytics in Athena.

---

##  Key Highlights

-> Simulates 70 randomized product transactions (price, quantity, total)

-> Streams data to **Amazon Kinesis**

-> Auto-ingests data via **AWS Lambda** into **Amazon S3**

-> Analyzes using **Amazon Athena** over JSON

-> Visualizes KPIs, bar, and time-series trends via **QuickSight**

-> Follows modular, production-grade architecture

---

##  Project Architecture

aws-retail-realtime-analytics/ ├── data-simulator/ # Python generator for transactions ├── lambda/ # AWS Lambda function to write S3 ├── sql/ # Athena DDL + Analytics queries ├── dashboards/ # QuickSight config notes ├── architecture/archi.png # End-to-end diagram (PNG) ├── .gitignore 


> 📷 **Architecture Diagram Included**  
> View: `architecture/archi.png`

---

## 🔁 Real-Time Data Simulation

Simulates 70 transactions from a pool of 5 products:

```json
{
  "transaction_id": "uuid",
  "timestamp": "2025-05-01T23:34:12",
  "product_id": 3,
  "product_name": "Sneakers",
  "price": 70,
  "quantity": 2,
  "total_amount": 140
}
cd data-simulator
python generate_transactions.py
```
## QuickSight Dashboard Setup
Source: Athena > retail_transactions
Visuals created:

 KPI: Total Revenue

 Bar Chart: Quantity by Product

Line Graph: Transactions over Time

SPICE Enabled for optimized querying

Reference config: dashboards/quicksight_config.txt

## Technologies Used
Amazon Kinesis – Real-time streaming

AWS Lambda – Event-driven ingestion

Amazon S3 – Scalable object storage

Amazon Athena – Serverless SQL over S3

Amazon QuickSight – Data visualization

Python – Data simulation + Lambda logic
