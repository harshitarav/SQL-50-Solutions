# Write your MySQL query statement below
WITH CTE1 AS (
SELECT *, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY customer_id, order_date) AS first_order
FROM Delivery
ORDER BY customer_id, order_date)


SELECT round((imm_order/tot_first_order)*100,2) AS immediate_percentage FROM (
SELECT DISTINCT (orders_count) AS tot_first_order, COUNT(*) OVER() AS imm_order FROM (
SELECT *, COUNT(delivery_id) OVER() AS orders_count FROM CTE1
WHERE first_order = 1) AS TAB2
WHERE order_date = customer_pref_delivery_date) AS TAB3;