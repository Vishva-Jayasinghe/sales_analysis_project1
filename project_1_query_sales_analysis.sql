DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * 
FROM retail_sales
LIMIT 100;

--NULL VALUES
SELECT *
FROM retail_sales
WHERE 	transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		gender IS NULL
		OR
		age IS NULL
		OR
		category IS NULL
		OR
		quantity IS NULL
		OR
		cogs IS NULL
		OR
		total_sale IS NULL
;

--DELETE NULL ROWS
DELETE FROM
retail_sales
WHERE 	transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		gender IS NULL
		OR
		age IS NULL
		OR
		category IS NULL
		OR
		quantity IS NULL
		OR
		cogs IS NULL
		OR
		total_sale IS NULL
;


SELECT COUNT(*)
FROM retail_sales;

--Important questions
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity  > 3
AND   TO_CHAR(sale_date,'YYYY-MM') = '2022-11';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
       SUM(total_sale) AS Total_sale
FROM retail_sales
GROUP BY category
ORDER BY SUM(total_sale);

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),3) AS age
FROM retail_sales
WHERE category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT transactions_id,
	   total_sale
FROM retail_sales
WHERE total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT COUNT(*) AS No_of_transactions,
	   gender,
	   category
FROM retail_sales
GROUP BY gender,category;	 

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT *
FROM(
		SELECT EXTRACT(YEAR FROM sale_date) AS Year,
			   EXTRACT(MONTH FROM sale_date) AS Month,
			   AVG(total_sale) AS Average_sale,
			   RANK () OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY  AVG(total_sale) DESC) AS rank
			
		FROM  retail_sales
		GROUP BY Year,Month
		) AS t
WHERE rank =1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,
	   SUM(total_sale) AS Total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_sale DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(DISTINCT customer_id) AS No_of_customers,
	   category
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales
AS (
		SELECT * ,
		CASE 
			WHEN EXTRACT(HOUR FROM sale_time) <12  THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17  THEN 'Aternoon'
			ELSE 'Evening'
		END AS shift
			
			
		
		FROM retail_sales
)
SELECT 	shift,
		COUNT(*) AS total_orders
FROM hourly_sales
GROUP  BY shift;


