-- Use Dictinct with Orderby to remove duplicate rows
DROP TABLE IF EXISTS retiring_emp_by_title;

SELECT distinct on (t.emp_no) e.emp_no, 
    e.first_name,
    e.last_name,
t.title,	
t.from_date,
t.to_date as title_to_date
into retiring_emp_by_title
FROM departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN employees e on de.emp_no = e.emp_no
JOIN titles t on e.emp_no = t.emp_no
WHERE e.emp_no in (SELECT emp_no FROM retirement_info)
AND de.to_date = ('9999-01-01') 
ORDER BY t.emp_no, t.to_date desc;

SELECT * FROM retiring_emp_by_title
