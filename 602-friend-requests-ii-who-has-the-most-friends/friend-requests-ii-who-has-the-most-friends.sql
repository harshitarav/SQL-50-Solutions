# Write your MySQL query statement below
WITH CTE1 AS (
SELECT requester_id, COUNT(accepter_id) AS c1
FROM RequestAccepted
GROUP BY requester_id),

CTE2 AS (
SELECT accepter_id, COUNT(requester_id) AS c2
FROM RequestAccepted
GROUP BY accepter_id)

SELECT id, num FROM (
SELECT requester_id AS id, SUM(c1) AS num, rank() OVER(ORDER BY SUM(c1) DESC) AS ranking FROM (
SELECT requester_id, c1 FROM CTE1 UNION ALL
SELECT accepter_id, c2 FROM CTE2) AS TAB1
GROUP BY requester_id) AS TAB2
WHERE ranking = 1;
