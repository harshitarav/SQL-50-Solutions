# Write your MySQL query statement below
WITH CTE1 AS (
SELECT *, sum(weight) OVER(ORDER BY turn) AS running_total FROM Queue
ORDER BY turn)

SELECT person_name FROM (
SELECT *, dense_rank() OVER(ORDER BY running_total DESC) AS name_rank FROM CTE1
WHERE running_total <=1000) AS TAB1
WHERE name_rank = 1;