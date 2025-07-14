# Write your MySQL query statement below
SELECT product_id, round(coalesce(sum_price/sum_units,0),2) AS average_price FROM (
SELECT product_id, sum(coalesce(units,0)) AS sum_units, sum(coalesce(total_price,0)) AS sum_price FROM (
SELECT p.product_id, p.price, u.units AS units, p.price*u.units AS total_price
FROM Prices p LEFT JOIN UnitsSold u
ON u.product_id = p.product_id AND (u.purchase_date >= p.start_date AND u.purchase_date <= p.end_date)) AS TAB1
GROUP BY product_id) AS TAB2;