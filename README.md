🛒 Retail Sales SQL Data Analysis Project
📌 Project Overview
This project focuses on analyzing retail sales data using SQL.
The objective is to clean the dataset, explore key business questions, and generate insights related to sales performance, customer behavior, and product categories.
This project demonstrates practical SQL skills required for a Data Analyst role, including:
Data Cleaning
Data Exploration
Aggregations
Grouping
Window Functions
Ranking
Common Table Expressions (CTEs)

🗂 Dataset Information
Table Name: retail_sales
📊 Table Structure
Column Name	Data Type
transactions_id	INT (Primary Key)
sale_date	DATE
sale_time	TIME
customer_id	INT
gender	VARCHAR(10)
age	INT
category	VARCHAR(35)
quantity	INT
price_per_unit	FLOAT
cogs	FLOAT
total_sale	FLOAT
🧹 Data Cleaning Process
1️⃣ Removing Existing Table
DROP TABLE IF EXISTS retail_sales;
2️⃣ Handling NULL Values
Checked for missing values in critical columns:

SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
Deleted rows containing NULL values:

DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
📈 Business Questions & SQL Solutions
🔹 Q1: Sales on Specific Date

Retrieve all sales made on 2022-11-05.

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
🔹 Q2: Clothing Sales (Nov 2022, Quantity > 3)
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity > 3
AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11';
🔹 Q3: Total Sales by Category
SELECT category,
       SUM(total_sale) AS Total_sale
FROM retail_sales
GROUP BY category
ORDER BY SUM(total_sale);
🔹 Q4: Average Age of Beauty Category Customers
SELECT ROUND(AVG(age),3) AS age
FROM retail_sales
WHERE category = 'Beauty';
🔹 Q5: Transactions with Total Sale > 1000
SELECT transactions_id,
       total_sale
FROM retail_sales
WHERE total_sale > 1000;
🔹 Q6: Total Transactions by Gender & Category
SELECT COUNT(*) AS No_of_transactions,
       gender,
       category
FROM retail_sales
GROUP BY gender, category;
🔹 Q7: Best Selling Month in Each Year (Window Function)

This query uses:

EXTRACT()

AVG()

RANK() OVER()

Window Functions

SELECT *
FROM(
    SELECT EXTRACT(YEAR FROM sale_date) AS Year,
           EXTRACT(MONTH FROM sale_date) AS Month,
           AVG(total_sale) AS Average_sale,
           RANK() OVER(
                PARTITION BY EXTRACT(YEAR FROM sale_date)
                ORDER BY AVG(total_sale) DESC
           ) AS rank
    FROM retail_sales
    GROUP BY Year, Month
) AS t
WHERE rank = 1;
🔹 Q8: Top 5 Customers by Total Sales
SELECT customer_id,
       SUM(total_sale) AS Total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_sale DESC
LIMIT 5;
🔹 Q9: Unique Customers by Category
SELECT COUNT(DISTINCT customer_id) AS No_of_customers,
       category
FROM retail_sales
GROUP BY category;
🔹 Q10: Sales by Shift (CTE + CASE Statement)

Shift Classification:

Morning → Hour < 12

Afternoon → 12 to 17

Evening → > 17

WITH hourly_sales AS (
    SELECT *,
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift,
       COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
🛠 Skills Demonstrated

Data Cleaning

Filtering

Aggregations (SUM, AVG, COUNT)

GROUP BY

ORDER BY

Window Functions (RANK)

CTE (Common Table Expressions)

Date Functions

Conditional Logic (CASE)

🚀 Tools Used

PostgreSQL

SQL

📌 Key Insights (Example)

Identified top-performing months per year.

Found high-value customers.

Analyzed sales performance by category.

Identified customer purchasing behavior by shift timing.

Measured customer demographics in specific categories.

🎯 Conclusion

This project demonstrates strong foundational SQL skills required for:

Data Analyst

Business Intelligence Analyst

Junior Data Scientist

It showcases real-world data cleaning, business question solving, and analytical thinking using SQL.
