# Write your MySQL query statement below
WITH CTE1 AS (
SELECT class, count(class) AS count_class FROM Courses
GROUP BY class
ORDER BY class)

SELECT class FROM CTE1
WHERE count_class >=5; 