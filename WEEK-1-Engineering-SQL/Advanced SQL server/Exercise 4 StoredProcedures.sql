CREATE DATABASE EmployeeProcedureDB;
GO

USE EmployeeProcedureDB;
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
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');
GO

INSERT INTO Employees VALUES
(1, 'John', 'Doe', 1, 5000.00, '2020-01-15'),
(2, 'Jane', 'Smith', 2, 6000.00, '2019-03-22'),
(3, 'Michael', 'Johnson', 3, 7000.00, '2018-07-30'),
(4, 'Emily', 'Davis', 4, 5500.00, '2021-11-05');
GO

-- =========================================
-- VERIFY DATA
-- =========================================

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

-- =====================================================
-- EXERCISE 1 : GET EMPLOYEES BY DEPARTMENT
-- =====================================================

GO
CREATE PROCEDURE sp_GetEmployeesByDepartment

    @DepartmentID INT

AS
BEGIN

    SELECT *

    FROM Employees

    WHERE DepartmentID = @DepartmentID;

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_GetEmployeesByDepartment 1;
GO

-- =====================================================
-- EXERCISE 2 : INSERT EMPLOYEE PROCEDURE
-- =====================================================

GO
CREATE PROCEDURE sp_InsertEmployee

    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE

AS
BEGIN

    INSERT INTO Employees
    (
        EmployeeID,
        FirstName,
        LastName,
        DepartmentID,
        Salary,
        JoinDate
    )

    VALUES
    (
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate
    );

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_InsertEmployee

5,
'Navneet',
'Singh',
3,
6500,
'2024-01-10';
GO

-- VERIFY INSERT

SELECT * FROM Employees;
GO

-- =====================================================
-- EXERCISE 3 : MODIFY STORED PROCEDURE
-- =====================================================

GO
ALTER PROCEDURE sp_GetEmployeesByDepartment

    @DepartmentID INT

AS
BEGIN

    SELECT

        EmployeeID,
        FirstName,
        LastName,
        Salary

    FROM Employees

    WHERE DepartmentID = @DepartmentID;

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_GetEmployeesByDepartment 1;
GO

-- =====================================================
-- EXERCISE 4 : DELETE PROCEDURE
-- =====================================================

DROP PROCEDURE IF EXISTS sp_InsertEmployee;
GO

-- =====================================================
-- EXERCISE 5 : RETURN DATA FROM PROCEDURE
-- =====================================================

GO
CREATE PROCEDURE sp_TotalEmployees

    @DepartmentID INT

AS
BEGIN

    SELECT COUNT(*) AS TotalEmployees

    FROM Employees

    WHERE DepartmentID = @DepartmentID;

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_TotalEmployees 3;
GO

-- =====================================================
-- EXERCISE 6 : OUTPUT PARAMETERS
-- =====================================================

GO
CREATE PROCEDURE sp_TotalSalary

    @DepartmentID INT,

    @TotalSalary DECIMAL(10,2) OUTPUT

AS
BEGIN

    SELECT
    @TotalSalary = SUM(Salary)

    FROM Employees

    WHERE DepartmentID = @DepartmentID;

END;
GO

-- EXECUTE PROCEDURE

DECLARE @Result DECIMAL(10,2);

EXEC sp_TotalSalary
3,
@Result OUTPUT;

SELECT @Result AS TotalSalary;
GO

-- =====================================================
-- EXERCISE 7 : UPDATE SALARY PROCEDURE
-- =====================================================

GO
CREATE PROCEDURE sp_UpdateEmployeeSalary

    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)

AS
BEGIN

    UPDATE Employees

    SET Salary = @NewSalary

    WHERE EmployeeID = @EmployeeID;

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_UpdateEmployeeSalary
1,
5500.00;
GO

-- =====================================================
-- EXERCISE 8 : BONUS PROCEDURE
-- =====================================================

GO
CREATE PROCEDURE sp_GiveBonus

    @DepartmentID INT,
    @BonusAmount DECIMAL(10,2)

AS
BEGIN

    UPDATE Employees

    SET Salary = Salary + @BonusAmount

    WHERE DepartmentID = @DepartmentID;

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_GiveBonus
1,
500.00;
GO

-- =====================================================
-- EXERCISE 9 : TRANSACTION PROCEDURE
-- =====================================================

GO
CREATE PROCEDURE sp_UpdateSalaryTransaction

    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)

AS
BEGIN

    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Employees

        SET Salary = @NewSalary

        WHERE EmployeeID = @EmployeeID;

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

    END CATCH

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_UpdateSalaryTransaction
2,
7500;
GO

-- =====================================================
-- EXERCISE 10 : DYNAMIC SQL
-- =====================================================

GO
CREATE PROCEDURE sp_DynamicEmployeeSearch

    @ColumnName VARCHAR(50),
    @Value VARCHAR(50)

AS
BEGIN

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL =
    'SELECT * FROM Employees WHERE '
    + @ColumnName
    + ' = '''
    + @Value
    + '''';

    EXEC sp_executesql @SQL;

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_DynamicEmployeeSearch
'FirstName',
'John';
GO

-- =====================================================
-- EXERCISE 11 : ERROR HANDLING
-- =====================================================

GO
CREATE PROCEDURE sp_ErrorHandling

    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)

AS
BEGIN

    BEGIN TRY

        UPDATE Employees

        SET Salary = @NewSalary

        WHERE EmployeeID = @EmployeeID;

        PRINT 'Salary Updated Successfully';

    END TRY

    BEGIN CATCH

        PRINT 'Error Occurred';

    END CATCH

END;
GO

-- EXECUTE PROCEDURE

EXEC sp_ErrorHandling
1,
8000;
GO