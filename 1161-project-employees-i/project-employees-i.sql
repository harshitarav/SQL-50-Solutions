# Write your MySQL query statement below
SELECT project_id, round(AVG(experience_years),2) AS average_years FROM (
SELECT p.project_id, e.experience_years FROM Employee e JOIN Project p
ON e.employee_id = p.employee_id) AS TAB1
GROUP BY project_id;