-- 1. Top 5 Best-Selling Products by Revenue
SELECT product_name, SUM(total_amount) AS revenue
FROM retail_transactions
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;

-- 2. Average Quantity per Transaction by Product
SELECT product_name, AVG(quantity) AS avg_qty
FROM retail_transactions
GROUP BY product_name;

-- 3. Sales by Hour of the Day
SELECT hour(from_iso8601_timestamp(timestamp)) AS hour,
       SUM(total_amount) AS hourly_sales
FROM retail_transactions
GROUP BY hour
ORDER BY hour;

-- 4. Daily Sales Trend
SELECT date(from_iso8601_timestamp(timestamp)) AS txn_date,
       SUM(total_amount) AS total_sales
FROM retail_transactions
GROUP BY txn_date
ORDER BY txn_date;

-- 5. Most Frequently Purchased Product
SELECT product_name, COUNT(*) AS purchase_count
FROM retail_transactions
GROUP BY product_name
ORDER BY purchase_count DESC
LIMIT 1;

-- 6. Products with Highest Average Sale Value
SELECT product_name, AVG(total_amount) AS avg_sale
FROM retail_transactions
GROUP BY product_name
ORDER BY avg_sale DESC;

-- 7. Minimum, Maximum, and Average Order Value
SELECT MIN(total_amount) AS min_order_value,
       MAX(total_amount) AS max_order_value,
       AVG(total_amount) AS avg_order_value
FROM retail_transactions;

-- 8. Total Sales by Product and Quantity Band
SELECT product_name,
       CASE 
           WHEN quantity = 1 THEN 'Single Item'
           WHEN quantity BETWEEN 2 AND 3 THEN 'Small Bundle'
           ELSE 'Bulk Purchase'
       END AS purchase_type,
       SUM(total_amount) AS total_sales
FROM retail_transactions
GROUP BY product_name, purchase_type;

-- 9. Transactions Above Average Order Value
WITH avg_order AS (
    SELECT AVG(total_amount) AS avg_val FROM retail_transactions
)
SELECT *
FROM retail_transactions, avg_order
WHERE total_amount > avg_val;

-- 10. Sales Percentage Contribution by Product
SELECT product_name,
       SUM(total_amount) AS product_sales,
       ROUND(100 * SUM(total_amount) / SUM(SUM(total_amount)) OVER (), 2) AS percentage_share
FROM retail_transactions
GROUP BY product_name;
