-- SQL Developer Internship - Task 4: Aggregate Functions
-- Comprehensive examples of aggregate functions (SUM, COUNT, AVG, MAX, MIN)

USE company_db;

-- ========================================
-- BASIC AGGREGATE FUNCTIONS
-- ========================================

-- 1. COUNT: Count total number of employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 2. COUNT with column: Count employees with phone numbers (non-NULL)
SELECT COUNT(phone) AS employees_with_phone
FROM employees;

-- 3. COUNT DISTINCT: Count unique job titles
SELECT COUNT(DISTINCT job_title) AS unique_job_titles
FROM employees;

-- 4. SUM: Calculate total salary expense for the company
SELECT SUM(salary) AS total_salary_expense
FROM employees;

-- 5. AVG: Calculate average salary across all employees
SELECT AVG(salary) AS average_salary
FROM employees;

-- 6. ROUND with AVG: Average salary rounded to 2 decimal places
SELECT ROUND(AVG(salary), 2) AS average_salary_rounded
FROM employees;

-- 7. MAX: Find the highest salary in the company
SELECT MAX(salary) AS highest_salary
FROM employees;

-- 8. MIN: Find the lowest salary in the company
SELECT MIN(salary) AS lowest_salary
FROM employees;

-- 9. Multiple aggregates in one query
SELECT 
    COUNT(*) AS total_employees,
    ROUND(AVG(salary), 2) AS avg_salary,
    SUM(salary) AS total_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM employees;

-- ========================================
-- AGGREGATE FUNCTIONS WITH CONDITIONS
-- ========================================

-- 10. Count employees hired after 2020
SELECT COUNT(*) AS employees_hired_after_2020
FROM employees
WHERE hire_date > '2020-12-31';

-- 11. Average salary for Engineering department
SELECT ROUND(AVG(salary), 2) AS avg_engineering_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE d.department_name = 'Engineering';

-- 12. Sum of salaries for managers (employees who are managers)
SELECT SUM(salary) AS total_manager_salaries
FROM employees
WHERE emp_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);

-- 13. Count employees with salary above average
SELECT COUNT(*) AS above_average_salary_count
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- ========================================
-- STRING AND DATE AGGREGATES
-- ========================================

-- 14. Count employees by first letter of last name
SELECT 
    LEFT(last_name, 1) AS first_letter,
    COUNT(*) AS employee_count
FROM employees
GROUP BY LEFT(last_name, 1)
ORDER BY first_letter;

-- 15. Average years of service (using current date)
SELECT ROUND(AVG(DATEDIFF(CURDATE(), hire_date) / 365.25), 2) AS avg_years_service
FROM employees;

-- ========================================
-- COMPLEX AGGREGATE SCENARIOS
-- ========================================

-- 16. Salary statistics for each job title
SELECT 
    job_title,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY job_title
ORDER BY avg_salary DESC;

-- 17. Department budget utilization
SELECT 
    d.department_name,
    d.budget AS allocated_budget,
    COALESCE(SUM(e.salary), 0) AS salary_expense,
    ROUND((COALESCE(SUM(e.salary), 0) / d.budget) * 100, 2) AS budget_utilization_percent
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.department_name, d.budget
ORDER BY budget_utilization_percent DESC;

-- 18. Project budget analysis
SELECT 
    status,
    COUNT(*) AS project_count,
    ROUND(AVG(budget), 2) AS avg_project_budget,
    SUM(budget) AS total_budget,
    MIN(budget) AS min_budget,
    MAX(budget) AS max_budget
FROM projects
GROUP BY status
ORDER BY total_budget DESC;

-- ========================================
-- ADVANCED AGGREGATE PATTERNS
-- ========================================

-- 19. Conditional aggregation using CASE
SELECT 
    COUNT(CASE WHEN salary >= 80000 THEN 1 END) AS high_salary_count,
    COUNT(CASE WHEN salary BETWEEN 60000 AND 79999 THEN 1 END) AS medium_salary_count,
    COUNT(CASE WHEN salary < 60000 THEN 1 END) AS low_salary_count
FROM employees;

-- 20. Running totals and percentages
SELECT 
    dept_id,
    COUNT(*) AS dept_employee_count,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM employees), 2) AS percentage_of_total
FROM employees
GROUP BY dept_id
ORDER BY dept_employee_count DESC;

-- Display completion message
SELECT 'Aggregate functions queries completed successfully!' AS Status;