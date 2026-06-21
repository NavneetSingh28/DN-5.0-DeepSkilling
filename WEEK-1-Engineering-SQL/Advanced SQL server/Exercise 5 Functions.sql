USE EmployeeFunctionDB;
GO

-- =========================================
-- DROP OLD FUNCTIONS
-- =========================================

DROP FUNCTION IF EXISTS fn_CalculateAnnualSalary;
DROP FUNCTION IF EXISTS fn_GetEmployeesByDepartment;
DROP FUNCTION IF EXISTS fn_CalculateBonus;
DROP FUNCTION IF EXISTS fn_CalculateTotalCompensation;
GO

-- =========================================
-- DROP OLD TABLES
-- =========================================

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

-- =========================================
-- CREATE TABLES
-- =========================================

CREATE TABLE Departments (

    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

CREATE TABLE Employees (

    EmployeeID INT PRIMARY KEY,

    FirstName VARCHAR(50),

    LastName VARCHAR(50),

    DepartmentID INT
    FOREIGN KEY REFERENCES Departments(DepartmentID),

    Salary DECIMAL(10,2),

    JoinDate DATE
);
GO

-- =========================================
-- INSERT SAMPLE DATA
-- =========================================

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance');
GO

INSERT INTO Employees VALUES
(1,'John','Doe',1,5000,'2020-01-15'),
(2,'Jane','Smith',2,6000,'2019-03-22'),
(3,'Bob','Johnson',3,5500,'2021-07-01');
GO

-- =========================================
-- VERIFY TABLES
-- =========================================

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

-- =====================================================
-- EXERCISE 1 : CREATE SCALAR FUNCTION
-- =====================================================

GO
CREATE FUNCTION fn_CalculateAnnualSalary

(
    @Salary DECIMAL(10,2)
)

RETURNS DECIMAL(10,2)

AS
BEGIN

    RETURN @Salary * 12;

END;
GO

-- TEST FUNCTION

SELECT
EmployeeID,
FirstName,
Salary,

dbo.fn_CalculateAnnualSalary(Salary)
AS AnnualSalary

FROM Employees;
GO

-- =====================================================
-- EXERCISE 2 : TABLE VALUED FUNCTION
-- =====================================================

GO
CREATE FUNCTION fn_GetEmployeesByDepartment

(
    @DepartmentID INT
)

RETURNS TABLE

AS

RETURN
(
    SELECT *

    FROM Employees

    WHERE DepartmentID = @DepartmentID
);
GO

-- TEST FUNCTION

SELECT *
FROM dbo.fn_GetEmployeesByDepartment(2);
GO

-- =====================================================
-- EXERCISE 3 : USER DEFINED FUNCTION
-- =====================================================

GO
CREATE FUNCTION fn_CalculateBonus

(
    @Salary DECIMAL(10,2)
)

RETURNS DECIMAL(10,2)

AS
BEGIN

    RETURN @Salary * 0.10;

END;
GO

-- TEST FUNCTION

SELECT
EmployeeID,
FirstName,
Salary,

dbo.fn_CalculateBonus(Salary)
AS Bonus

FROM Employees;
GO

-- =====================================================
-- EXERCISE 4 : MODIFY FUNCTION
-- =====================================================

GO
ALTER FUNCTION fn_CalculateBonus

(
    @Salary DECIMAL(10,2)
)

RETURNS DECIMAL(10,2)

AS
BEGIN

    RETURN @Salary * 0.15;

END;
GO

-- TEST MODIFIED FUNCTION

SELECT
EmployeeID,
FirstName,
Salary,

dbo.fn_CalculateBonus(Salary)
AS ModifiedBonus

FROM Employees;
GO

-- =====================================================
-- EXERCISE 5 : DELETE FUNCTION
-- =====================================================

DROP FUNCTION fn_CalculateBonus;
GO

-- VERIFY FUNCTION DELETED

SELECT *
FROM sys.objects
WHERE name = 'fn_CalculateBonus';
GO

-- =====================================================
-- RECREATE BONUS FUNCTION
-- =====================================================

GO
CREATE FUNCTION fn_CalculateBonus

(
    @Salary DECIMAL(10,2)
)

RETURNS DECIMAL(10,2)

AS
BEGIN

    RETURN @Salary * 0.15;

END;
GO

-- =====================================================
-- EXERCISE 6 : EXECUTE FUNCTION
-- =====================================================

SELECT
EmployeeID,
FirstName,

dbo.fn_CalculateAnnualSalary(Salary)
AS AnnualSalary

FROM Employees;
GO

-- =====================================================
-- EXERCISE 7 : RETURN DATA FROM FUNCTION
-- =====================================================

SELECT

dbo.fn_CalculateAnnualSalary(Salary)
AS AnnualSalary

FROM Employees

WHERE EmployeeID = 1;
GO

-- =====================================================
-- EXERCISE 8 : TABLE FUNCTION RESULT
-- =====================================================

SELECT *
FROM dbo.fn_GetEmployeesByDepartment(3);
GO

-- =====================================================
-- EXERCISE 9 : NESTED FUNCTION
-- =====================================================

GO
CREATE FUNCTION fn_CalculateTotalCompensation

(
    @Salary DECIMAL(10,2)
)

RETURNS DECIMAL(10,2)

AS
BEGIN

    RETURN
    dbo.fn_CalculateAnnualSalary(@Salary)
    +
    dbo.fn_CalculateBonus(@Salary);

END;
GO

-- TEST FUNCTION

SELECT
EmployeeID,
FirstName,
Salary,

dbo.fn_CalculateTotalCompensation(Salary)
AS TotalCompensation

FROM Employees;
GO

-- =====================================================
-- EXERCISE 10 : MODIFY NESTED FUNCTION
-- =====================================================

GO
ALTER FUNCTION fn_CalculateTotalCompensation

(
    @Salary DECIMAL(10,2)
)

RETURNS DECIMAL(10,2)

AS
BEGIN

    RETURN
    dbo.fn_CalculateAnnualSalary(@Salary)
    +
    (@Salary * 0.20);

END;
GO

-- TEST MODIFIED FUNCTION

SELECT
EmployeeID,
FirstName,
Salary,

dbo.fn_CalculateTotalCompensation(Salary)
AS ModifiedTotalCompensation

FROM Employees;
GO