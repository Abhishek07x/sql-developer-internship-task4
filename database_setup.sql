-- SQL Developer Internship - Task 4: Database Setup
-- Creates company database with sample data for aggregate functions practice

-- Create database
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

-- Create departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50),
    budget DECIMAL(12,2)
);

-- Create employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    hire_date DATE,
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- Create projects table
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12,2),
    status VARCHAR(20),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Create employee_projects junction table
CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    role VARCHAR(50),
    hours_allocated INT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- Insert sample departments
INSERT INTO departments (department_name, location, budget) VALUES
('Engineering', 'Building A', 500000.00),
('Sales', 'Building B', 300000.00),
('Marketing', 'Building B', 200000.00),
('HR', 'Building C', 150000.00),
('Finance', 'Building C', 250000.00);

-- Insert sample employees
INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, dept_id, manager_id) VALUES
('John', 'Doe', 'john.doe@company.com', '555-0001', '2020-01-15', 'Senior Software Engineer', 95000.00, 1, NULL),
('Jane', 'Smith', 'jane.smith@company.com', '555-0002', '2021-03-20', 'Software Engineer', 75000.00, 1, 1),
('Mike', 'Johnson', 'mike.johnson@company.com', '555-0003', '2019-06-10', 'Lead Developer', 105000.00, 1, NULL),
('Sarah', 'Williams', 'sarah.williams@company.com', '555-0004', '2022-02-14', 'Junior Developer', 65000.00, 1, 3),
('David', 'Brown', 'david.brown@company.com', '555-0005', '2020-08-05', 'Sales Manager', 85000.00, 2, NULL),
('Lisa', 'Davis', 'lisa.davis@company.com', '555-0006', '2021-11-12', 'Sales Representative', 55000.00, 2, 5),
('Tom', 'Wilson', 'tom.wilson@company.com', '555-0007', '2023-01-08', 'Sales Representative', 52000.00, 2, 5),
('Emma', 'Taylor', 'emma.taylor@company.com', '555-0008', '2020-04-22', 'Marketing Manager', 70000.00, 3, NULL),
('Chris', 'Anderson', 'chris.anderson@company.com', '555-0009', '2022-07-18', 'Marketing Specialist', 50000.00, 3, 8),
('Amy', 'Martinez', 'amy.martinez@company.com', '555-0010', '2019-12-03', 'HR Manager', 75000.00, 4, NULL);

-- Insert sample projects
INSERT INTO projects (project_name, start_date, end_date, budget, status, dept_id) VALUES
('Mobile App Development', '2023-01-01', '2023-12-31', 200000.00, 'Active', 1),
('E-commerce Platform', '2023-03-15', '2024-03-15', 350000.00, 'Active', 1),
('Customer Analytics', '2023-06-01', '2023-11-30', 120000.00, 'Completed', 1),
('Q4 Sales Campaign', '2023-10-01', '2023-12-31', 80000.00, 'Active', 2),
('Lead Generation System', '2023-05-01', '2024-04-30', 150000.00, 'Active', 2),
('Brand Awareness Campaign', '2023-07-01', '2023-12-31', 90000.00, 'Active', 3),
('Social Media Strategy', '2023-09-01', '2024-02-29', 60000.00, 'Active', 3),
('Employee Training Program', '2023-04-01', '2024-03-31', 75000.00, 'Active', 4);

-- Insert employee-project assignments
INSERT INTO employee_projects (emp_id, project_id, role, hours_allocated) VALUES
(1, 1, 'Lead Developer', 160),
(2, 1, 'Frontend Developer', 160),
(3, 2, 'Technical Lead', 120),
(4, 2, 'Backend Developer', 160),
(1, 3, 'Data Analyst', 80),
(5, 4, 'Campaign Manager', 120),
(6, 4, 'Sales Coordinator', 100),
(7, 5, 'Lead Generation Specialist', 140),
(8, 6, 'Creative Director', 100),
(9, 6, 'Content Creator', 120),
(9, 7, 'Social Media Manager', 80),
(10, 8, 'Training Coordinator', 100);

-- Create some additional sample data for better analysis
-- Add more employees for comprehensive grouping examples
INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, dept_id, manager_id) VALUES
('Robert', 'Garcia', 'robert.garcia@company.com', '555-0011', '2021-09-15', 'Senior Sales Rep', 75000.00, 2, 5),
('Maria', 'Rodriguez', 'maria.rodriguez@company.com', '555-0012', '2022-01-20', 'Financial Analyst', 68000.00, 5, NULL),
('Kevin', 'Lee', 'kevin.lee@company.com', '555-0013', '2020-11-30', 'DevOps Engineer', 88000.00, 1, 3),
('Jessica', 'White', 'jessica.white@company.com', '555-0014', '2023-03-10', 'Junior Marketing Analyst', 45000.00, 3, 8),
('Daniel', 'Clark', 'daniel.clark@company.com', '555-0015', '2019-08-25', 'Finance Manager', 92000.00, 5, NULL);

SHOW TABLES;
SELECT 'Database setup completed successfully!' AS Status;