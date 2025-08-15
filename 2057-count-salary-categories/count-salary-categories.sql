# Write your MySQL query statement below
WITH sample_count AS (
    SELECT 'Low Salary' AS category
    UNION ALL SELECT 'Average Salary'
    UNION ALL SELECT 'High Salary'
),

CTE1 AS (
SELECT *,
CASE 
   WHEN income < 20000 THEN 'Low Salary'
   WHEN income between 20000 AND 50000 THEN 'Average Salary'
   WHEN income > 50000 THEN 'High Salary'
END AS category
FROM Accounts)

SELECT c.category, COALESCE(accounts_count,0) AS accounts_count FROM sample_count c LEFT JOIN (
SELECT category, COUNT(category) AS accounts_count FROM CTE1
GROUP BY category) AS TAB1
ON c.category = TAB1.category;