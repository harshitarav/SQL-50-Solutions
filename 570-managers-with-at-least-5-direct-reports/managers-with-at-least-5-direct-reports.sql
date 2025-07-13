SELECT name FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY managerId ORDER BY ROWNUM DESC) AS ranknum FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY e1.managerId ORDER BY e1.managerId) AS ROWNUM FROM (
SELECT e1.id, e1.name AS emp_name, e1.managerId, e2.name AS name FROM Employee e1 JOIN Employee e2
ON e1.managerId = e2.id
ORDER BY e1.id) AS TAB) AS TAB1
WHERE ROWNUM >=5) AS TAB3
WHERE ranknum = 1;