# Write your MySQL query statement below
SELECT distinctrow employee_id, name, reports_count, round(average_age) AS average_age FROM (
SELECT e1.employee_id, e1.name, COUNT(e1.employee_id) OVER(PARTITION BY e1.employee_id) AS reports_count, AVG(e2.age) OVER(PARTITION BY e1.employee_id) AS average_age FROM Employees e1 JOIN Employees e2
ON e1.employee_id = e2.reports_to) AS TAB1;
