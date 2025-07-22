# Write your MySQL query statement below
WITH CTE1 AS (
SELECT num AS numm, COUNT(num) OVER(PARTITION BY num) AS count_numm FROM MyNumbers)

SELECT max(num) AS num FROM (
SELECT *,
CASE 
  WHEN count_numm != 1 THEN null
  WHEN count_numm = 1 THEN numm
END AS num  
FROM CTE1) AS TAB1;