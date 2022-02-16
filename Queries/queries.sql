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

drop table if exists retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT e.emp_no,
    e.first_name,
    e.last_name,
de.to_date
into current_emp
FROM departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN employees e on de.emp_no = e.emp_no
WHERE e.emp_no in (SELECT emp_no FROM retirement_info)
AND de.to_date = ('9999-01-01');
					
					
-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;	


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
into retiring_counts_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

drop table emp_info;
SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');
	 
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no); 
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


-- Current Sales employees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO sales_dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no and d.dept_name = 'Sales')
and ce.emp_no in (SELECT emp_no from retirement_info);

SELECT d.dept_name, count(*)
FROM sales_dept_info sd 
INNER JOIN dept_emp AS de
ON (sd.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
group by d.dept_name


SELECT * from unique_titles;













		