# Write your MySQL query statement below
WITH CTE1 AS (
SELECT *, 
SUM(CASE 
   WHEN (prev_num = num) THEN 0 ELSE 1 
END) OVER(ORDER BY id) AS new_val   
FROM (
SELECT *, lag(num) OVER(order by id) AS prev_num FROM Logs) AS TAB1)

SELECT DISTINCT num AS ConsecutiveNums FROM (
SELECT *, COUNT(new_val) OVER(PARTITION BY new_val) AS count_num FROM CTE1) AS TAB1
WHERE count_num >=3;