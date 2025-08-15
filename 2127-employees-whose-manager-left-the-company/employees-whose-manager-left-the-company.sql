# Write your MySQL query statement below
WITH CTE1 AS (
SELECT TAB1.employee_id, coalesce(e1.manager_id,0) AS manager_exist, e1.employee_id AS e1_emp FROM (
SELECT * FROM Employees
WHERE salary < 30000 AND manager_id IS NOT NULL) AS TAB1 LEFT JOIN Employees e1
ON TAB1.manager_id = e1.employee_id
)

SELECT employee_id FROM CTE1
WHERE e1_emp IS NULL
ORDER BY employee_id;