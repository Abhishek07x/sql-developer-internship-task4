-- SQL Developer Internship - Task 4: GROUP BY Queries
-- Comprehensive examples of grouping data with GROUP BY clause

USE company_db;

-- ========================================
-- BASIC GROUP BY EXAMPLES
-- ========================================

-- 1. Count employees by department
SELECT 
    d.department_name,
    COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.department_name
ORDER BY employee_count DESC;

-- 2. Average salary by department
SELECT 
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.department_name
ORDER BY avg_salary DESC;

-- 3. Total salary expense by department
SELECT 
    d.department_name,
    SUM(e.salary) AS total_salary_expense
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.department_name
ORDER BY total_salary_expense DESC;

-- 4. Salary statistics by job title
SELECT 
    job_title,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees
GROUP BY job_title
ORDER BY avg_salary DESC;

-- ========================================
-- MULTIPLE COLUMN GROUPING
-- ========================================

-- 5. Employee count by department and job title
SELECT 
    d.department_name,
    e.job_title,
    COUNT(e.emp_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.department_name, e.job_title
ORDER BY d.department_name, avg_salary DESC;

-- 6. Hiring trends by year and department
SELECT 
    YEAR(e.hire_date) AS hire_year,
    d.department_name,
    COUNT(e.emp_id) AS hires_count
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY YEAR(e.hire_date), d.department_name
ORDER BY hire_year DESC, hires_count DESC;

-- 7. Salary ranges by department and experience level
SELECT 
    d.department_name,
    CASE 
        WHEN DATEDIFF(CURDATE(), e.hire_date) / 365 < 2 THEN 'Junior (0-2 years)'
        WHEN DATEDIFF(CURDATE(), e.hire_date) / 365 < 5 THEN 'Mid-level (2-5 years)'
        ELSE 'Senior (5+ years)'
    END AS experience_level,
    COUNT(e.emp_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.department_name, 
    CASE 
        WHEN DATEDIFF(CURDATE(), e.hire_date) / 365 < 2 THEN 'Junior (0-2 years)'
        WHEN DATEDIFF(CURDATE(), e.hire_date) / 365 < 5 THEN 'Mid-level (2-5 years)'
        ELSE 'Senior (5+ years)'
    END
ORDER BY d.department_name, avg_salary DESC;

-- ========================================
-- DATE-BASED GROUPING
-- ========================================

-- 8. Employees hired by year
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS employees_hired,
    ROUND(AVG(salary), 2) AS avg_starting_salary
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

-- 9. Employees hired by month (current year)
SELECT 
    MONTHNAME(hire_date) AS hire_month,
    COUNT(*) AS employees_hired
FROM employees
WHERE YEAR(hire_date) = 2023
GROUP BY MONTH(hire_date), MONTHNAME(hire_date)
ORDER BY MONTH(hire_date);

-- 10. Quarterly hiring analysis
SELECT 
    YEAR(hire_date) AS hire_year,
    CONCAT('Q', QUARTER(hire_date)) AS quarter,
    COUNT(*) AS employees_hired,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY YEAR(hire_date), QUARTER(hire_date)
ORDER BY hire_year DESC, QUARTER(hire_date);

-- ========================================
-- PROJECT-RELATED GROUPING
-- ========================================

-- 11. Projects by department and status
SELECT 
    d.department_name,
    p.status,
    COUNT(p.project_id) AS project_count,
    ROUND(AVG(p.budget), 2) AS avg_budget,
    SUM(p.budget) AS total_budget
FROM departments d
LEFT JOIN projects p ON d.dept_id = p.dept_id
GROUP BY d.department_name, p.status
ORDER BY d.department_name, total_budget DESC;

-- 12. Employee project assignments
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    COUNT(ep.project_id) AS projects_assigned,
    SUM(ep.hours_allocated) AS total_hours_allocated
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id, e.first_name, e.last_name, d.department_name
ORDER BY projects_assigned DESC, total_hours_allocated DESC;

-- ========================================
-- ADVANCED GROUPING SCENARIOS
-- ========================================

-- 13. Salary distribution analysis
SELECT 
    CASE 
        WHEN salary < 50000 THEN '< $50K'
        WHEN salary < 70000 THEN '$50K - $70K'
        WHEN salary < 90000 THEN '$70K - $90K'
        ELSE '$90K+'
    END AS salary_range,
    COUNT(*) AS employee_count,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM employees), 2) AS percentage
FROM employees
GROUP BY 
    CASE 
        WHEN salary < 50000 THEN '< $50K'
        WHEN salary < 70000 THEN '$50K - $70K'
        WHEN salary < 90000 THEN '$70K - $90K'
        ELSE '$90K+'
    END
ORDER BY MIN(salary);

-- 14. Manager vs Non-Manager analysis
SELECT 
    CASE 
        WHEN e.emp_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL) 
        THEN 'Manager' 
        ELSE 'Non-Manager' 
    END AS employee_type,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees e
GROUP BY 
    CASE 
        WHEN e.emp_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL) 
        THEN 'Manager' 
        ELSE 'Non-Manager' 
    END;

-- 15. Department performance metrics
SELECT 
    d.department_name,
    COUNT(e.emp_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    COUNT(p.project_id) AS active_projects,
    COALESCE(SUM(p.budget), 0) AS total_project_budget,
    ROUND(d.budget / COUNT(e.emp_id), 2) AS budget_per_employee
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN projects p ON d.dept_id = p.dept_id AND p.status = 'Active'
GROUP BY d.dept_id, d.department_name, d.budget
ORDER BY employee_count DESC;

-- ========================================
-- GROUPING WITH CALCULATIONS
-- ========================================

-- 16. Cost per project by department
SELECT 
    d.department_name,
    COUNT(DISTINCT p.project_id) AS total_projects,
    COUNT(DISTINCT ep.emp_id) AS employees_involved,
    SUM(ep.hours_allocated) AS total_hours,
    ROUND(AVG(e.salary / 2080 * ep.hours_allocated), 2) AS estimated_labor_cost
FROM departments d
JOIN projects p ON d.dept_id = p.dept_id
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.emp_id = e.emp_id
GROUP BY d.dept_id, d.department_name
ORDER BY estimated_labor_cost DESC;

-- 17. Team size analysis by project
SELECT 
    p.project_name,
    p.status,
    COUNT(ep.emp_id) AS team_size,
    SUM(ep.hours_allocated) AS total_allocated_hours,
    ROUND(AVG(ep.hours_allocated), 2) AS avg_hours_per_person,
    p.budget,
    ROUND(p.budget / COUNT(ep.emp_id), 2) AS budget_per_team_member
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name, p.status, p.budget
ORDER BY team_size DESC;

-- Display completion message
SELECT 'GROUP BY queries completed successfully!' AS Status;