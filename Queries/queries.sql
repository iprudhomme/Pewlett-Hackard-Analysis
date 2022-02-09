-- Get the counts of all the tables in one result set
SELECT count(*) counts, 'departments' table_name FROM departments
union all
SELECT count(*) counts, 'employees' table_name FROM employees
union all
SELECT count(*) counts, 'dept_emp' table_name FROM dept_emp
union all
SELECT count(*) counts, 'dept_manager' table_name FROM dept_manager
union all
SELECT count(*) counts, 'salaries' table_name FROM salaries
union all
SELECT count(*) counts, 'titles' table_name FROM titles;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
										
