--Verifying the orders table
SELECT *
FROM orders;

--Verifying the people table
SELECT *
FROM people;

--Looking at sales column
SELECT sales
FROM orders;

--Looking at sum of sales
SELECT SUM(sales) AS sum_sales
FROM orders;

--Using CTE with examples found here:  https://www.sqlservertutorial.net/sql-server-basics/sql-server-cte/
--Create the CTE
WITH region_manager_sales (manager, sales, year) 
AS (
	SELECT
		p.regional_manager,
		SUM(o.sales),
		o.year
	FROM
		people as p
	RIGHT JOIN
		orders as o ON p.region = o.region
	GROUP BY 
	p.regional_manager,
	o.year
)
--Using the CTE in a query
SELECT 
	manager,
	sales
FROM region_manager_sales
WHERE year = '2020';

--Using CTE to calculate number of orders and average sales per order
WITH region_manager_sales (manager, sales, order_count, year) 
AS (
	SELECT
		p.regional_manager,
		SUM(o.sales),
		COUNT(DISTINCT o.order_id),
		o.year
	FROM
		people as p
	RIGHT JOIN
		orders as o ON p.region = o.region
	GROUP BY 
	p.regional_manager,
	o.year
)
--Using the CTE in a query
SELECT 
	manager,
	sales AS total_sales,
	order_count,
	sales/order_count AS average_order
FROM region_manager_sales
WHERE year = '2020'
ORDER BY sales DESC;
