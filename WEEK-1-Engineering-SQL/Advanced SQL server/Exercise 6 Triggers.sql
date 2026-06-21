
USE EmployeeTriggerDB;
GO

-- =========================================
-- DROP OLD TRIGGERS
-- =========================================

DROP TRIGGER IF EXISTS trg_AfterSalaryUpdate;
GO

DROP TRIGGER IF EXISTS trg_PreventDelete;
GO

DROP TRIGGER IF EXISTS trg_LogonRestriction
ON ALL SERVER;
GO

DROP TRIGGER IF EXISTS trg_UpdateAnnualSalary;
GO

-- =========================================
-- DROP OLD TABLES
-- =========================================

DROP TABLE IF EXISTS EmployeeChanges;
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
(2,'Finance'),
(3,'IT'),
(4,'Marketing');
GO

INSERT INTO Employees VALUES
(1,'John','Doe',1,5000,'2022-01-15'),
(2,'Jane','Smith',2,6000,'2021-03-22'),
(3,'Michael','Johnson',3,7000,'2020-07-30'),
(4,'Emily','Davis',4,5500,'2019-11-05');
GO

-- =========================================
-- VERIFY DATA
-- =========================================

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

-- =====================================================
-- EXERCISE 1 : AFTER TRIGGER
-- =====================================================

CREATE TABLE EmployeeChanges (

    ChangeID INT IDENTITY(1,1) PRIMARY KEY,

    EmployeeID INT,

    OldSalary DECIMAL(10,2),

    NewSalary DECIMAL(10,2),

    ChangeDate DATETIME
);
GO

CREATE TRIGGER trg_AfterSalaryUpdate

ON Employees

AFTER UPDATE

AS
BEGIN

    INSERT INTO EmployeeChanges
    (
        EmployeeID,
        OldSalary,
        NewSalary,
        ChangeDate
    )

    SELECT

        d.EmployeeID,
        d.Salary,
        i.Salary,
        GETDATE()

    FROM deleted d

    JOIN inserted i
    ON d.EmployeeID = i.EmployeeID

    WHERE d.Salary <> i.Salary;

END;
GO

-- TEST TRIGGER

UPDATE Employees
SET Salary = 6500
WHERE EmployeeID = 1;
GO

SELECT * FROM EmployeeChanges;
GO

-- =====================================================
-- EXERCISE 2 : INSTEAD OF DELETE TRIGGER
-- =====================================================

CREATE TRIGGER trg_PreventDelete

ON Employees

INSTEAD OF DELETE

AS
BEGIN

    RAISERROR
    (
        'Deletion is not allowed from Employees table',
        16,
        1
    );

END;
GO

-- TEST TRIGGER

DELETE FROM Employees
WHERE EmployeeID = 2;
GO

-- =====================================================
-- EXERCISE 3 : LOGON TRIGGER
-- =====================================================

CREATE TRIGGER trg_LogonRestriction

ON ALL SERVER

FOR LOGON

AS
BEGIN

    DECLARE @CurrentHour INT;

    SET @CurrentHour = DATEPART(HOUR, GETDATE());

    IF @CurrentHour >= 2
    AND @CurrentHour < 3

    BEGIN

        ROLLBACK;

        RAISERROR
        (
            'Login restricted during maintenance hours',
            16,
            1
        );

    END

END;
GO

-- =====================================================
-- EXERCISE 4 : MODIFY TRIGGER
-- =====================================================

ALTER TRIGGER trg_AfterSalaryUpdate

ON Employees

AFTER UPDATE

AS
BEGIN

    INSERT INTO EmployeeChanges
    (
        EmployeeID,
        OldSalary,
        NewSalary,
        ChangeDate
    )

    SELECT

        d.EmployeeID,
        d.Salary,
        i.Salary,
        GETDATE()

    FROM deleted d

    JOIN inserted i
    ON d.EmployeeID = i.EmployeeID

    WHERE d.Salary <> i.Salary;

    PRINT 'Salary Updated Successfully';

END;
GO

-- TEST MODIFIED TRIGGER

UPDATE Employees
SET Salary = 7000
WHERE EmployeeID = 1;
GO

SELECT * FROM EmployeeChanges;
GO

-- =====================================================
-- EXERCISE 5 : DELETE TRIGGER
-- =====================================================

DROP TRIGGER trg_PreventDelete;
GO

-- VERIFY DELETION

SELECT *
FROM sys.triggers
WHERE name = 'trg_PreventDelete';
GO

-- =====================================================
-- EXERCISE 6 : COMPUTED COLUMN TRIGGER
-- =====================================================

ALTER TABLE Employees

ADD AnnualSalary DECIMAL(10,2);
GO

CREATE TRIGGER trg_UpdateAnnualSalary

ON Employees

AFTER UPDATE

AS
BEGIN

    UPDATE Employees

    SET AnnualSalary = Salary * 12

    WHERE EmployeeID IN
    (
        SELECT EmployeeID
        FROM inserted
    );

END;
GO

-- TEST COMPUTED COLUMN TRIGGER

UPDATE Employees
SET Salary = 8000
WHERE EmployeeID = 3;
GO

SELECT * FROM Employees;
GO

