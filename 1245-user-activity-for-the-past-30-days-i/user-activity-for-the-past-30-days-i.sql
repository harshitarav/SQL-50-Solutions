# Write your MySQL query statement below
WITH CTE1 AS (
SELECT * FROM Activity
WHERE activity_date BETWEEN ('2019-06-28') AND ('2019-07-27'))

SELECT activity_date AS day, COUNT( DISTINCT user_id) AS active_users FROM CTE1
GROUP BY activity_date;