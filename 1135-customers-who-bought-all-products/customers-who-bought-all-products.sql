# Write your MySQL query statement below
SELECT customer_id FROM (
SELECT customer_id, COUNT(DISTINCT p.product_key) AS count_row FROM Customer c RIGHT JOIN Product p
ON c.product_key = p.product_key
GROUP BY customer_id
ORDER BY customer_id) AS TAB1
WHERE count_row = (SELECT COUNT(product_key) FROM Product);