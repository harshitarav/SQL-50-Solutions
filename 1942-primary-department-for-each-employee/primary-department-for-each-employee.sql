# Write your MySQL query statement below
WITH CTE1 AS (
SELECT *, COUNT(department_id) OVER(PARTITION BY employee_id) AS count_dep
FROM Employee)

SELECT employee_id, dep AS department_id FROM (
SELECT *,
CASE 
  WHEN count_dep = 1 THEN department_id
  WHEN (count_dep >1 AND primary_flag = 'Y') THEN department_id
END AS dep
FROM CTE1) AS TAB1
WHERE dep IS NOT NULL;