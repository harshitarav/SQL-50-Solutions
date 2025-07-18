# Write your MySQL query statement below
WITH MONTHCTE AS (
SELECT *, DATE_FORMAT(trans_date, '%Y-%m') AS new_date FROM Transactions
),

CTE2 AS (SELECT *, SUM(amount) OVER(PARTITION BY country, new_date) AS trans_total_amount, ROW_NUMBER() OVER(PARTITION BY country, new_date) AS trans_count FROM MONTHCTE
ORDER BY id
)

SELECT new_date AS month, country, trans_count, approved_count, trans_total_amount, approved_total_amount FROM (
SELECT *, sum(num) OVER(PARTITION BY country, new_date) AS approved_count, sum(amount_new) OVER(PARTITION BY country, new_date) AS approved_total_amount FROM (
SELECT *, ROW_NUMBER() OVER(PARTITION BY country, new_date ORDER BY trans_count DESC) AS row_numm, 
CASE 
  WHEN state = 'approved' THEN 1
  ELSE 0
END AS num,
CASE 
  WHEN state = 'approved' THEN amount
  ELSE 0
END AS amount_new
FROM CTE2) TAB1) AS TAB2
WHERE row_numm = 1;