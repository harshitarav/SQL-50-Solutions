# Write your MySQL query statement below
WITH CTE1 AS (
SELECT customer_id, COUNT(DISTINCT p.product_key) AS count_row FROM Customer c RIGHT JOIN Product p
ON c.product_key = p.product_key
GROUP BY customer_id
ORDER BY customer_id)

SELECT customer_id FROM CTE1
WHERE count_row = (SELECT COUNT(product_key) FROM Product);