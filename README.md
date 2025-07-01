# Task 6: Subqueries and Nested Queries

# 💻 SQL Developer Internship - Task 6: Subqueries and Nested Queries

## 📌 Objective
This task focuses on mastering **subqueries** and **nested query logic** in SQL using clauses such as `SELECT`, `WHERE`, and `FROM`. It also covers scalar subqueries, correlated subqueries, and derived tables.

---

## 🗂️ Tables Used

### 🧾 Departments
| Column Name     | Data Type    |
|-----------------|--------------|
| DepartmentID    | INT (Primary Key) |
| DepartmentName  | VARCHAR(100) |

### 🧾 Employees
| Column Name     | Data Type    |
|-----------------|--------------|
| EmpID           | INT (Primary Key) |
| Name            | VARCHAR(100) |
| DepartmentID    | INT (Foreign Key) |
| Salary          | INT          |

---

## 🛠️ Key SQL Queries Used

### ✅ 1. Scalar Subquery in SELECT
```sql
SELECT 
    Name,
    Salary,
    (SELECT AVG(Salary) FROM Employees) AS AverageSalary
FROM Employees;

 2. Subquery in WHERE using IN
SELECT Name
FROM Employees
WHERE DepartmentID IN (
    SELECT DepartmentID
    FROM Departments
    WHERE DepartmentName = 'IT'
);

