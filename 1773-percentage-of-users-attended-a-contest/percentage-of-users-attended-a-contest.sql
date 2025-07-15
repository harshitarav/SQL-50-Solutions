SELECT contest_id, percentage FROM (
SELECT contest_id, percentage, row_number() OVER(PARTITION BY percentage ORDER BY contest_id ASC) AS row_n FROM (
SELECT * FROM (
SELECT round((row_rank/total_users)*100,2) AS percentage, contest_id
FROM (
SELECT * FROM (
SELECT contest_id, total_users, user_id, row_rank, rank() OVER(PARTITION BY contest_id ORDER BY row_rank DESC) AS row_num FROM (
SELECT *, rank() OVER(PARTITION BY contest_id ORDER BY user_id DESC) AS row_rank FROM (
SELECT contest_id, u.user_id, (SELECT COUNT(user_id) FROM Users) AS total_users
FROM Users u JOIN Register r
ON u.user_id = r.user_id
ORDER BY contest_id) AS TAB1) AS TAB2) AS TAB3
WHERE row_num = 1) AS TAB4
ORDER BY contest_id) AS TAB5) AS TAB6
ORDER BY percentage DESC, contest_id ASC)
AS TAB7;