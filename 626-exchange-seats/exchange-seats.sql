# Write your MySQL query statement below
WITH CTE1 AS (
SELECT *,
CASE 
   WHEN id%2 !=0 THEN id+1
   WHEN id%2 = 0 THEN id-1
END AS new_id
FROM Seat),

CTE2 AS (
SELECT *, 
CASE
  WHEN new_student IS NULL THEN old_student
  WHEN new_student IS NOT NULL THEN new_student
END AS new_name 
 FROM (
SELECT CTE1.id,CTE1.student AS old_student,s.student AS new_student FROM CTE1 LEFT JOIN Seat s
ON CTE1.new_id = s.id) AS TAB1)

SELECT id, new_name AS student
FROM CTE2;