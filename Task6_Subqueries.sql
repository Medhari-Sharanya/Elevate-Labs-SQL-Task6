

mysql>create database Task6;
Query OK, 1 row affected (0.01 sec)
mysql> use Task6;
Database changed
mysql> -- Drop tables if they already exist
mysql> DROP TABLE IF EXISTS Employees;
Query OK, 0 rows affected (0.02 sec)

mysql> DROP TABLE IF EXISTS Departments;
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> -- Create Departments table
mysql> CREATE TABLE Departments (
    ->     DepartmentID INT PRIMARY KEY,
    ->     DepartmentName VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql> -- Create Employees table
mysql> CREATE TABLE Employees (
    ->     EmpID INT PRIMARY KEY,
    ->     Name VARCHAR(100),
    ->     DepartmentID INT,
    ->     Salary INT,
    ->     FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> -- Insert Departments
mysql> INSERT INTO Departments VALUES
    -> (1, 'HR'),
    -> (2, 'IT'),
    -> (3, 'Finance');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert Employees
mysql> INSERT INTO Employees VALUES
    -> (101, 'Alice', 1, 50000),
    -> (102, 'Bob', 2, 70000),
    -> (103, 'Charlie', 2, 60000),
    -> (104, 'David', 3, 55000),
    -> (105, 'Eva', 1, 52000),
    -> (106, 'Frank', 3, 53000);
Query OK, 6 rows affected (0.01 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> SELECT
    ->     Name,
    ->     Salary,
    ->     (SELECT AVG(Salary) FROM Employees) AS AverageSalary
    -> FROM Employees;
+---------+--------+---------------+
| Name    | Salary | AverageSalary |
+---------+--------+---------------+
| Alice   |  50000 |    56666.6667 |
| Bob     |  70000 |    56666.6667 |
| Charlie |  60000 |    56666.6667 |
| David   |  55000 |    56666.6667 |
| Eva     |  52000 |    56666.6667 |
| Frank   |  53000 |    56666.6667 |
+---------+--------+---------------+
6 rows in set (0.01 sec)

mysql> SELECT Name
    -> FROM Employees
    -> WHERE DepartmentID IN (
    ->     SELECT DepartmentID
    ->     FROM Departments
    ->     WHERE DepartmentName = 'IT'
    -> );
+---------+
| Name    |
+---------+
| Bob     |
| Charlie |
+---------+
2 rows in set (0.00 sec)

mysql> SELECT Name
    -> FROM Employees e
    -> WHERE EXISTS (
    ->     SELECT 1
    ->     FROM Departments d
    ->     WHERE d.DepartmentID = e.DepartmentID AND d.DepartmentName = 'HR'
    -> );
+-------+
| Name  |
+-------+
| Alice |
| Eva   |
+-------+
2 rows in set (0.00 sec)

mysql> SELECT Name, Salary
    -> FROM Employees e1
    -> WHERE Salary > (
    ->     SELECT AVG(Salary)
    ->     FROM Employees e2
    ->     WHERE e1.DepartmentID = e2.DepartmentID
    -> );
+-------+--------+
| Name  | Salary |
+-------+--------+
| Bob   |  70000 |
| David |  55000 |
| Eva   |  52000 |
+-------+--------+
3 rows in set (0.00 sec)

mysql> SELECT DepartmentID, AvgSalary
    -> FROM (
    ->     SELECT DepartmentID, AVG(Salary) AS AvgSalary
    ->     FROM Employees
    ->     GROUP BY DepartmentID
    -> ) AS DepartmentSalaries;
+--------------+------------+
| DepartmentID | AvgSalary  |
+--------------+------------+
|            1 | 51000.0000 |
|            2 | 65000.0000 |
|            3 | 54000.0000 |
+--------------+------------+
3 rows in set (0.01 sec)

mysql> -- Find employee(s) earning the maximum salary
mysql> SELECT Name, Salary
    -> FROM Employees
    -> WHERE Salary = (
    ->     SELECT MAX(Salary)
    ->     FROM Employees
    -> );
+------+--------+
| Name | Salary |
+------+--------+
| Bob  |  70000 |
+------+--------+
1 row in set (0.01 sec)

mysql>






