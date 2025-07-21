# Write your MySQL query statement below
WITH CTE1 AS (
SELECT *, DENSE_RANK() OVER(PARTITION BY product_id ORDER BY year) AS fy FROM Sales)

SELECT product_id, year AS first_year, quantity, price FROM CTE1
WHERE fy = 1;