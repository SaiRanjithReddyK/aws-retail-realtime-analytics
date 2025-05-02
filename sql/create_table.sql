

CREATE EXTERNAL TABLE IF NOT EXISTS retail_transactions (
  transaction_id STRING,
  timestamp STRING,
  product_id INT,
  product_name STRING,
  price INT,
  quantity INT,
  total_amount INT
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = '1'
)
LOCATION 's3://your-bucket-name/transactions/';
