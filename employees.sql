-- salario medio de la gente que trabaja de senior engineer
USE employees;

SELECT AVG(S.salary), T.title
FROM salaries AS S
INNER JOIN titles AS T
ON S.emp_no = T.emp_no
WHERE T.title = "Senior Engineer";

-- SUBQUERY: SELECT adentro de otro SELECT
SELECT emp_no FROM employees WHERE last_name = "Bernini";
SELECT salary, from_date, to_date FROM salaries WHERE emp_no = "10056";

SELECT employees.first_name, employees.last_name, salaries.salary
FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE salaries.salary > (SELECT salary FROM salaries WHERE emp_no = "10056" AND from_date = "1990-02-01" AND to_date = "1991-02-01");

select e.last_name, s.salary
from employees e
inner join salaries s on s.emp_no = e.emp_no
where s.salary in (select s.salary
					where s.salary >= (SELECT salary FROM salaries WHERE emp_no = "10056" AND from_date = "1990-02-01" AND to_date = "1991-02-01"));

select e.last_name, s.salary
from employees e
inner join salaries s on s.emp_no = e.emp_no
 where s.salary in (select s.salary
					where s.salary > (e.last_name="Facello"));
