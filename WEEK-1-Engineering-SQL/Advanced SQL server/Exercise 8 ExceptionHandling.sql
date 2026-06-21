USE EmployeeTriggerDB;
GO

-- =========================================
-- DROP OLD PROCEDURES
-- =========================================

DROP PROCEDURE IF EXISTS AddEmployee;
DROP PROCEDURE IF EXISTS TransferEmployee;
DROP PROCEDURE IF EXISTS BatchInsertEmployees;
GO

-- =========================================
-- DROP OLD TABLES
-- =========================================

DROP TABLE IF EXISTS AuditLog;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

-- =========================================
-- CREATE TABLES
-- =========================================

CREATE TABLE Departments (

    DepartmentID INT PRIMARY KEY,

    DepartmentName VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Employees (

    EmployeeID INT PRIMARY KEY,

    FirstName VARCHAR(50),

    LastName VARCHAR(50),

    Email VARCHAR(100) UNIQUE,

    Salary DECIMAL(10,2),

    DepartmentID INT,

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);
GO

CREATE TABLE AuditLog (

    LogID INT IDENTITY(1,1) PRIMARY KEY,

    Action VARCHAR(100),

    ErrorMessage VARCHAR(4000),

    ActionDate DATETIME DEFAULT GETDATE()
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
(1,'John','Doe','john1@gmail.com',5000,1),
(2,'Jane','Smith','jane1@gmail.com',6000,2);
GO

-- =========================================
-- VERIFY TABLES
-- =========================================

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

-- =====================================================
-- QUESTION 1 : BASIC TRY...CATCH
-- =====================================================

GO
CREATE PROCEDURE AddEmployee

    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT

AS
BEGIN

    BEGIN TRY

        INSERT INTO Employees
        VALUES
        (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @Salary,
            @DepartmentID
        );

        PRINT 'Employee Added Successfully';

    END TRY

    BEGIN CATCH

        INSERT INTO AuditLog
        (
            Action,
            ErrorMessage
        )

        VALUES
        (
            'Add Employee',
            ERROR_MESSAGE()
        );

        PRINT 'Error Logged';

    END CATCH

END;
GO

-- TEST PROCEDURE

EXEC AddEmployee
3,
'Bob',
'Johnson',
'bob@gmail.com',
5500,
1;
GO

SELECT * FROM AuditLog;
GO

-- =====================================================
-- QUESTION 2 : THROW
-- =====================================================

GO
ALTER PROCEDURE AddEmployee

    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT

AS
BEGIN

    BEGIN TRY

        INSERT INTO Employees
        VALUES
        (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @Salary,
            @DepartmentID
        );

    END TRY

    BEGIN CATCH

        INSERT INTO AuditLog
        (
            Action,
            ErrorMessage
        )

        VALUES
        (
            'Add Employee',
            ERROR_MESSAGE()
        );

        THROW;

    END CATCH

END;
GO

-- TEST THROW

EXEC AddEmployee
4,
'Sam',
'Wilson',
'john1@gmail.com',
4500,
2;
GO

-- =====================================================
-- QUESTION 3 : RAISERROR
-- =====================================================

GO
ALTER PROCEDURE AddEmployee

    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT

AS
BEGIN

    BEGIN TRY

        IF @Salary <= 0

        BEGIN

            RAISERROR
            (
                'Salary must be greater than zero.',
                16,
                1
            );

        END

        INSERT INTO Employees
        VALUES
        (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @Salary,
            @DepartmentID
        );

    END TRY

    BEGIN CATCH

        INSERT INTO AuditLog
        (
            Action,
            ErrorMessage
        )

        VALUES
        (
            'Salary Validation',
            ERROR_MESSAGE()
        );

        PRINT ERROR_MESSAGE();

    END CATCH

END;
GO

-- TEST RAISERROR

EXEC AddEmployee
5,
'Tom',
'Harris',
'tom@gmail.com',
-100,
1;
GO

SELECT * FROM AuditLog;
GO

-- =====================================================
-- QUESTION 4 : NESTED TRY...CATCH
-- =====================================================

GO
CREATE PROCEDURE TransferEmployee

    @EmployeeID INT,
    @NewDepartmentID INT

AS
BEGIN

    BEGIN TRY

        BEGIN TRY

            IF NOT EXISTS
            (
                SELECT *
                FROM Departments
                WHERE DepartmentID = @NewDepartmentID
            )

            BEGIN

                RAISERROR
                (
                    'Department does not exist.',
                    16,
                    1
                );

            END

            UPDATE Employees

            SET DepartmentID = @NewDepartmentID

            WHERE EmployeeID = @EmployeeID;

            PRINT 'Transfer Successful';

        END TRY

        BEGIN CATCH

            INSERT INTO AuditLog
            (
                Action,
                ErrorMessage
            )

            VALUES
            (
                'Transfer Employee',
                ERROR_MESSAGE()
            );

            THROW;

        END CATCH

    END TRY

    BEGIN CATCH

        PRINT 'Nested Error Occurred';

    END CATCH

END;
GO

-- TEST NESTED TRY...CATCH

EXEC TransferEmployee
1,
10;
GO

SELECT * FROM AuditLog;
GO

-- =====================================================
-- QUESTION 5 : TRANSACTION + TRY...CATCH
-- =====================================================

GO
CREATE PROCEDURE BatchInsertEmployees

AS
BEGIN

    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO Employees
        VALUES
        (
            6,
            'David',
            'Miller',
            'david@gmail.com',
            5000,
            1
        );

        INSERT INTO Employees
        VALUES
        (
            7,
            'Chris',
            'Evans',
            'john1@gmail.com',
            6000,
            2
        );

        COMMIT TRANSACTION;

        PRINT 'Transaction Successful';

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        INSERT INTO AuditLog
        (
            Action,
            ErrorMessage
        )

        VALUES
        (
            'Batch Insert',
            ERROR_MESSAGE()
        );

        PRINT 'Transaction Rolled Back';

    END CATCH

END;
GO

-- TEST TRANSACTION

EXEC BatchInsertEmployees;
GO

SELECT * FROM AuditLog;
GO

-- =====================================================
-- QUESTION 6 : DYNAMIC RAISERROR
-- =====================================================

GO
ALTER PROCEDURE AddEmployee

    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT

AS
BEGIN

    BEGIN TRY

        IF @Salary < 0

        BEGIN

            RAISERROR
            (
                'Negative salary is not allowed.',
                16,
                1
            );

        END

        ELSE IF @Salary < 1000

        BEGIN

            RAISERROR
            (
                'Salary is very low.',
                10,
                1
            );

        END

        INSERT INTO Employees
        VALUES
        (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @Salary,
            @DepartmentID
        );

        PRINT 'Employee Added';

    END TRY

    BEGIN CATCH

        INSERT INTO AuditLog
        (
            Action,
            ErrorMessage
        )

        VALUES
        (
            'Dynamic Error',
            ERROR_MESSAGE()
        );

        PRINT ERROR_MESSAGE();

    END CATCH

END;
GO

-- TEST DYNAMIC RAISERROR

EXEC AddEmployee
8,
'Peter',
'Parker',
'peter@gmail.com',
500,
1;
GO

SELECT * FROM AuditLog;
GO