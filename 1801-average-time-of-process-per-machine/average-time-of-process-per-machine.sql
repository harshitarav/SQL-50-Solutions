# Write your MySQL query statement below
WITH TAB1 AS (
SELECT machine_id, process_id, activity_type, timestamp FROM
(SELECT *, max(timestamp) OVER (PARTITION BY machine_id) AS max_stamp FROM Activity) AS TEMPTABLE1
WHERE activity_type = 'start'),

TAB2 AS (
SELECT machine_id, process_id, activity_type, timestamp FROM
(SELECT *, max(timestamp) OVER (PARTITION BY machine_id) AS max_stamp FROM Activity) AS TEMPTABLE2
WHERE activity_type = 'end')

SELECT machine_id, round(avg(time),3) AS processing_time FROM (
SELECT t1.machine_id, t1.process_id, t2.timestamp-t1.timestamp AS time FROM TAB1 t1
JOIN TAB2 t2
ON (t1.machine_id = t2.machine_id && t1.process_id = t2.process_id)) AS FINALTAB
GROUP BY machine_id;