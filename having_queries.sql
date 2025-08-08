-- SQL Developer Internship - Task 4: HAVING Clause Queries
-- Examples demonstrating difference between WHERE and HAVING

USE company_db;

-- ========================================
-- BASIC HAVING EXAMPLES
-- ========================================

-- 1. Departments with more than 2 employees
SELECT 
    d.department_name,
    COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.department_name
HAVING COUNT(e.emp_id) > 2
ORDER BY employee_count DESC;

-- 2. Departments with average salary above $70,000
SELECT 
    d.department_name,
    COUNT(e.emp_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.department_name
HAVING AVG(e.salary) > 70000
ORDER BY avg_salary DESC;

-- 3. Job titles with more than 1 employee
SELECT 
    job_title,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY job_title
HAVING COUNT(*) > 1
ORDER BY employee_count DESC;

-- ========================================
-- HAVING WITH MULTIPLE CONDITIONS
-- ========================================

-- 4. Departments with high employee count AND high average salary
SELECT 
    d.department_name,
    COUNT(e.emp_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.department_name
HAVING COUNT(e.emp_id) >= 3 AND AVG(e.salary) > 60000
ORDER BY avg_salary DESC;

-- 5. Projects with budget over $100K and active status
SELECT 
    d.department_name,
    COUNT(p.project_id) AS project_count,
    ROUND(AVG(p.budget), 2) AS avg_budget,