SQL Developer Internship - Task 4: Aggregate Functions and Grouping

Objective:-
Use aggregate functions and grouping to summarize data effectively using MySQL.

Key Concepts Covered:-
(1) Aggregation: Using SUM, COUNT, AVG, MAX, MIN functions
(2) Grouping: Using GROUP BY to categorize data
(3) Filtering Groups: Using HAVING clause
(4) Data Analysis: Summarizing and analyzing tabular data

Tools Used:-
  MySQL Workbench
  MySQL Server

Database Setup:-
 Sample Database: Company Management System
   Created a comprehensive database with the following tables:

(1) employees: Employee information with salaries and departments
(2) departments: Department details
(3) projects: Project information with budgets
(4) employee_projects: Many-to-many relationship between employees and projects

SQL Queries Implemented:-
1. Basic Aggregate Functions

 (a) Calculate total salary expense
 (b) Count total number of employees
 (c) Find average salary across company
 (d) Determine highest and lowest salaries

2. GROUP BY Operations

 (a) Employee count by department
 (b) Average salary by department
 (c) Total salary expense by department
 (d) Project count by department

3. HAVING Clause Usage

 (a) Departments with more than 2 employees
 (b) Departments with average salary above company average
 (c) High-budget departments (total salary > 200,000)

4. Advanced Grouping

(a) Multi-column grouping (department and job title)
(b) Salary statistics by experience level
(c) Department performance metrics

5. Complex Analysis

(a) Top-paying departments
(b) Employee distribution analysis
(c) Budget allocation by department
(d) Salary range analysis

Files in Repository:-

(1) database_setup.sql - Creates database and tables with sample data
(2) aggregate_queries.sql - All aggregate function examples
(3) grouping_queries.sql - GROUP BY examples
(4) having_queries.sql - HAVING clause examples
(5) README.md - This documentation



Sample Query Results
Employee Count by Department:
+------------------+----------------+
| department_name  | employee_count |
+------------------+----------------+
| Engineering      |              4 |
| Sales            |              3 |
| Marketing        |              2 |
| HR               |              1 |
+------------------+----------------+
Average Salary by Department:
+------------------+----------------+
| department_name  | avg_salary     |
+------------------+----------------+
| Engineering      |        87500.00|
| Sales            |        65000.00|
| Marketing        |        60000.00|
| HR               |        55000.00|
+------------------+----------------+

Skills Demonstrated:-

(1) Database design and setup
(2) Aggregate function usage (SUM, COUNT, AVG, MAX, MIN)
(3) Data grouping and categorization
(4) Conditional filtering with HAVING
(5) Complex data analysis queries
(6) Result formatting and presentation

Conclusion
This task demonstrates proficiency in using SQL aggregate functions and grouping capabilities to perform meaningful data analysis. The queries show various real-world scenarios where these functions are essential for business intelligence and reporting.

Author: Abhishek Tiwari
Date: 08-08-2025
Task: SQL Developer Internship - Task 4