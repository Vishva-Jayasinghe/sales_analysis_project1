[README_Retail_Sales_SQL_Project.md](https://github.com/user-attachments/files/25768947/README_Retail_Sales_SQL_Project.md)
# 🛒 Retail Sales SQL Data Analysis Project

## 📌 Project Overview

This project analyzes retail sales data using SQL.\
The goal is to clean the dataset and answer key business questions to
generate insights about:

-   Sales performance\
-   Customer behavior\
-   Category performance\
-   Monthly trends

This project demonstrates practical SQL skills required for a Data
Analyst role.

------------------------------------------------------------------------

## 🗂 Dataset Information

**Table Name:** `retail_sales`

### 📊 Table Structure

  Column Name       Data Type
  ----------------- -------------------
  transactions_id   INT (Primary Key)
  sale_date         DATE
  sale_time         TIME
  customer_id       INT
  gender            VARCHAR(10)
  age               INT
  category          VARCHAR(35)
  quantity          INT
  price_per_unit    FLOAT
  cogs              FLOAT
  total_sale        FLOAT

------------------------------------------------------------------------

# 🧹 Data Cleaning

## Drop Existing Table

``` sql
DROP TABLE IF EXISTS retail_sales;
```

## Check for NULL Values

``` sql
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
```

## Delete NULL Rows

``` sql
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
```

------------------------------------------------------------------------

# 📈 Business Questions & SQL Solutions

## Q1: Sales on 2022-11-05

``` sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

## Q2: Clothing Sales (Nov 2022, Quantity \> 3)

``` sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 3
  AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11';
```

## Q3: Total Sales by Category

``` sql
SELECT category,
       SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY category
ORDER BY total_sale;
```

## Q4: Average Age (Beauty Category)

``` sql
SELECT ROUND(AVG(age),3) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

## Q5: Transactions with Total Sale \> 1000

``` sql
SELECT transactions_id,
       total_sale
FROM retail_sales
WHERE total_sale > 1000;
```

## Q6: Transactions by Gender & Category

``` sql
SELECT COUNT(*) AS no_of_transactions,
       gender,
       category
FROM retail_sales
GROUP BY gender, category;
```

## Q7: Best Selling Month in Each Year (Window Function)

``` sql
SELECT *
FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS average_sale,
           RANK() OVER (
               PARTITION BY EXTRACT(YEAR FROM sale_date)
               ORDER BY AVG(total_sale) DESC
           ) AS rank
    FROM retail_sales
    GROUP BY year, month
) AS t
WHERE rank = 1;
```

## Q8: Top 5 Customers by Total Sales

``` sql
SELECT customer_id,
       SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

## Q9: Unique Customers by Category

``` sql
SELECT COUNT(DISTINCT customer_id) AS no_of_customers,
       category
FROM retail_sales
GROUP BY category;
```

## Q10: Sales by Shift (CTE + CASE)

``` sql
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
```

------------------------------------------------------------------------

# 🛠 Skills Demonstrated

-   Data Cleaning\
-   Filtering\
-   Aggregations (SUM, AVG, COUNT)\
-   GROUP BY\
-   ORDER BY\
-   Window Functions (RANK)\
-   CTE (Common Table Expressions)\
-   Date Functions\
-   CASE Statements

------------------------------------------------------------------------

# 🚀 Tools Used

-   PostgreSQL\
-   SQL

------------------------------------------------------------------------

# 🎯 Conclusion

This project demonstrates strong foundational SQL skills including data
cleaning, business question solving, aggregation, and analytical
thinking using SQL.
