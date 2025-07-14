# Write your MySQL query statement below
SELECT user_id, ROUND(avg(action_modi),2) AS confirmation_rate FROM (
SELECT s.user_id,
CASE 
   WHEN c.action IS NULL THEN 0
   WHEN c.action = 'timeout' THEN 0
   ELSE 1
END AS action_modi
FROM Signups s LEFT JOIN Confirmations c 
ON s.user_id = c.user_id) AS TAB1
GROUP BY user_id;
