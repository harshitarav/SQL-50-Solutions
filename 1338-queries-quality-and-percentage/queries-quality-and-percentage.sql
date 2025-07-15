# Write your MySQL query statement below
WITH QUERY_CTE AS (
SELECT query_name, position, rating, (rating/position) AS query
FROM Queries)

SELECT DISTINCT query_name, quality, (AVG(count_rate) OVER (PARTITION BY query_name)*100) AS poor_query_percentage
FROM (
SELECT *,
CASE 
  WHEN rating <3 THEN 1
  ELSE 0
END AS count_rate FROM (
SELECT query_name, rating, round(AVG(query) OVER(PARTITION BY query_name),2) AS quality FROM QUERY_CTE)
AS TAB1) AS TAB3;