# Write your MySQL query statement below
SELECT tweet_id FROM Tweets t 
WHERE LENGTH(t.content) > 15;