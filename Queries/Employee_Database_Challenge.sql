DROP TABLE IF EXISTS retirement_titles;

SELECT
    e.emp_no, 
    e.first_name,
    e.last_name,
    t.title,
	t.from_date,
	t.to_date
into retirement_titles
FROM departments d
JOIN dept_emp de on d.dept_no = de.dept_no
JOIN employees e on de.emp_no = e.emp_no
JOIN titles t on e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY t.emp_no, t.to_date desc;

DROP TABLE IF EXISTS unique_titles;
-- Create unique retirement titles
SELECT DISTINCT ON (emp_no) 
    emp_no, 
    first_name,
    last_name,
    title
into unique_titles	
FROM retirement_titles
WHERE to_date = ('9999-01-01') 
ORDER BY emp_no, to_date desc;

-- Create a table holding the retiring count by titles
DROP TABLE IF EXISTS retiring_titles;
SELECT title, count(emp_no) as count 
into retiring_titles
FROM unique_titles
group by title;

SELECT * 
FROM retiring_titles 

-- Select Mentorship program employees
SELECT DISTINCT ON (t.emp_no)
    e.emp_no, 
    e.first_name,
    e.last_name,
	e.birth_date,
	de.from_date as de_from_date,
	de.to_date as de_to_date,
    t.title
into mentorship_eligibility	
FROM employees e 
JOIN dept_emp de on e.emp_no = de.emp_no
JOIN titles t on e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = ('9999-01-01') 
ORDER BY t.emp_no, t.to_date desc;

SELECT title, COUNT(emp_no) as emp_count 
FROM mentorship_eligibility
GROUP BY title;	


--####### Additional Queries ###### ---- 

-- Retiring Count by Departments
SELECT dept_name, title, COUNT(ut.emp_no) AS dept_count
INTO retiring_by_dept 
FROM unique_titles ut
JOIN dept_emp de on ut.emp_no = de.emp_no
JOIN departments d on de.dept_no = d.dept_no 
WHERE de.to_date = ('9999-01-01') 
GROUP BY dept_name, title
ORDER BY 1,2

-- Retiring Count by Departments
SELECT dept_name, title, COUNT(ut.emp_no) dept_count
INTO mentorship_by_dept
FROM mentorship_eligibility ut
JOIN dept_emp de on ut.emp_no = de.emp_no
JOIN departments d on de.dept_no = d.dept_no 
WHERE de.to_date = ('9999-01-01') 
GROUP BY dept_name, title
ORDER BY dept_name, title

-- selecting missing employees from the mentorship program
SELECT 
	rd.dept_name as dept_name,
	rd.title as title,
	md.dept_count as mentor_count,
	rd.dept_count as retiring_count
FROM mentorship_by_dept md
FULL OUTER JOIN retiring_by_dept rd 
	ON md.dept_name = rd.dept_name AND md.title = rd.title
WHERE md.dept_count IS null	



 
 
 
 


