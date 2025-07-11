# Write your MySQL query statement below
WITH CC AS (
SELECT *,
CASE 
  WHEN e_subject_name IS NULL THEN 0
  ELSE row_num
  END AS attended_exams
FROM (
SELECT s.student_id, s.student_name, s.subject_name AS s_subject_name, e.subject_name AS e_subject_name, ROW_NUMBER () OVER (PARTITION BY s.student_id, s.subject_name ORDER BY s.subject_name) AS row_num FROM 
(SELECT student_id, student_name, subject_name FROM Students s JOIN Subjects sub
ORDER BY student_id) AS s
LEFT JOIN Examinations e
ON s.student_id = e.student_id AND s.subject_name = e.subject_name) AS t)

SELECT student_id, student_name, subject_name, attended_exams FROM (
SELECT student_id, student_name, s_subject_name AS subject_name, attended_exams, ROW_NUMBER() OVER(PARTITION BY student_id, s_subject_name ORDER BY attended_exams DESC) AS row_numm
FROM CC) AS QA
WHERE row_numm = 1;