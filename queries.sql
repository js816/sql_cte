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
WITH region_manager_sales (manager, sales) AS (
	SELECT
		p.regional_manager,
		SUM(o.sales)
	FROM
		people as p
	RIGHT JOIN
		orders as o ON p.region = o.region
	GROUP BY 
	p.regional_manager
)

SELECT 
	manager,
	sales
FROM region_manager_sales;
