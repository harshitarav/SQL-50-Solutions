WITH CTE1 AS (
SELECT user_id, COUNT(user_id) AS count_user
FROM MovieRating
GROUP BY user_id),

CTE2 AS (
SELECT name FROM (
SELECT name, count_user FROM Users u JOIN CTE1
WHERE u.user_id = CTE1.user_id
ORDER BY count_user DESC, name ASC) AS TAB10
LIMIT 1),

CTE3 AS (
SELECT * FROM (
SELECT movie_id, round(AVG(rating),2) AS avg_rating FROM MovieRating
WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY movie_id) AS TAB2 
ORDER BY avg_rating DESC, movie_id ASC
),

CTE4 AS (
SELECT CTE3.movie_id, CTE3.avg_rating, m.title FROM CTE3 JOIN Movies m 
WHERE CTE3.movie_id = m.movie_id
ORDER BY avg_rating DESC, title ASC
),

CTE5 AS (
SELECT title FROM CTE4
LIMIT 1
),

CTE6 AS (
SELECT name AS results FROM CTE2
UNION ALL SELECT title FROM CTE5)

SELECT * FROM CTE6;