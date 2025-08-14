WITH CTE2 AS (
SELECT *, MIN(change_date) OVER(PARTITION BY product_id ORDER BY product_id) AS min_date
FROM Products),

CTE3 AS (
SELECT *, 
CASE 
   WHEN (min_date > '2019-08-16') THEN '2019-08-16'
ELSE change_date 
END AS new_date
FROM CTE2),

CTE4 AS (
SELECT *,
CASE 
   WHEN (change_date != new_date) THEN 10
   ELSE new_price
END AS newest_price
FROM CTE3), 

CTE5 AS (
SELECT *,
CASE
  WHEN min_date = 0 THEN 1
  WHEN (MIN(min_date) OVER(PARTITION BY product_id) !=0 AND new_date < '2019-08-16' ) THEN 1
END AS new_col
FROM (
SELECT product_id, new_date, newest_price, datediff('2019-08-16',new_date) AS min_date
FROM CTE4) AS NEW_TAB)

SELECT DISTINCT product_id, newest_price AS price FROM (
SELECT *, RANK() OVER(PARTITION BY product_id ORDER BY new_date DESC) AS rank_date FROM CTE5 
WHERE new_col = 1) AS TB2
WHERE rank_date = 1;