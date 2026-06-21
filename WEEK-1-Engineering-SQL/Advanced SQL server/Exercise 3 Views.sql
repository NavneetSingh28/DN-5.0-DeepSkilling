CREATE DATABASE EmployeeManagementDB;
GO

USE EmployeeManagementDB;
GO

-- =====================================
-- DROP OLD TABLES
-- =====================================

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

-- =====================================
-- CREATE TABLES
-- =====================================

CREATE TABLE Departments (

    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

CREATE TABLE Employees (

    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,

    Salary DECIMAL(10,2),

    JoinDate DATE,

    FOREIGN KEY(DepartmentID)
    REFERENCES Departments(DepartmentID)
);
GO

-- =====================================
-- INSERT SAMPLE DATA
-- =====================================

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance');
GO

INSERT INTO Employees VALUES
(101,'Navneet','Singh',2,50000,'2023-01-10'),
(102,'Rahul','Sharma',1,40000,'2022-06-15'),
(103,'Aman','Kumar',3,60000,'2021-03-20');
GO

-- =====================================
-- VERIFY TABLES
-- =====================================

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

-- =====================================================
-- EXERCISE 1 : SIMPLE VIEW
-- =====================================================

GO
CREATE VIEW vw_EmployeeBasicInfo AS

SELECT

    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName

FROM Employees e

JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
GO

SELECT * FROM vw_EmployeeBasicInfo;
GO

-- =====================================================
-- EXERCISE 2 : FULL NAME VIEW
-- =====================================================

GO
CREATE VIEW vw_EmployeeFullName AS

SELECT

    EmployeeID,

    FirstName + ' ' + LastName
    AS FullName,

    Salary

FROM Employees;
GO

SELECT * FROM vw_EmployeeFullName;
GO

-- =====================================================
-- EXERCISE 3 : ANNUAL SALARY VIEW
-- =====================================================

GO
CREATE VIEW vw_EmployeeAnnualSalary AS

SELECT

    EmployeeID,
    FirstName,
    LastName,
    Salary,

    Salary * 12
    AS AnnualSalary

FROM Employees;
GO

SELECT * FROM vw_EmployeeAnnualSalary;
GO

-- =====================================================
-- EXERCISE 4 : EMPLOYEE REPORT VIEW
-- =====================================================

GO
CREATE VIEW vw_EmployeeReport AS

SELECT

    e.EmployeeID,

    e.FirstName + ' ' + e.LastName
    AS FullName,

    d.DepartmentName,

    e.Salary * 12
    AS AnnualSalary,

    (e.Salary * 12) * 0.10
    AS Bonus

FROM Employees e

JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
GO

SELECT * FROM vw_EmployeeReport;
GO