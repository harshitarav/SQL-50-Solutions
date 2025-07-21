# Write your MySQL query statement below
SELECT activity_date AS day, COUNT( DISTINCT user_id) AS active_users FROM 
(SELECT * FROM Activity
WHERE activity_date BETWEEN ('2019-06-28') AND ('2019-07-27')) AS TAB1
GROUP BY activity_date;