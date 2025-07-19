# Write your MySQL query statement below
WITH CTE2 AS(
SELECT COUNT(DISTINCT player_id) AS num_players FROM Activity),

CTE3 AS (
SELECT * FROM (
SELECT *, datediff(event_date,new_date) AS date_diff FROM (
SELECT * ,
CASE 
  WHEN row_num > 1 THEN (MIN(event_date) OVER(PARTITION BY player_id))
  ELSE event_date
END AS new_date
FROM (
SELECT *, row_number() OVER(PARTITION BY player_id ORDER BY event_date) row_num FROM (
SELECT * FROM Activity
ORDER BY player_id, event_date) AS TAB1) AS TAB2) AS TAB3) AS TAB4
WHERE date_diff = 1)


SELECT round(COUNT(*)/(SELECT * FROM CTE2),2) AS fraction FROM CTE3;
