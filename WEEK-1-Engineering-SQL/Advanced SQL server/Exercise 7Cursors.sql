
USE EmployeeTriggerDB;
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
(3,'Bob','Johnson',3,5500,'2021-07-30');
GO

-- =========================================
-- VERIFY TABLES
-- =========================================

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

-- =====================================================
-- EXERCISE 1 : CREATE CURSOR
-- =====================================================

DECLARE

    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE;

DECLARE EmployeeCursor CURSOR

FOR

SELECT
EmployeeID,
FirstName,
LastName,
DepartmentID,
Salary,
JoinDate

FROM Employees;

-- OPEN CURSOR

OPEN EmployeeCursor;

-- FETCH DATA

FETCH NEXT FROM EmployeeCursor

INTO

@EmployeeID,
@FirstName,
@LastName,
@DepartmentID,
@Salary,
@JoinDate;

-- LOOP

WHILE @@FETCH_STATUS = 0

BEGIN

    PRINT
    'Employee ID: '
    + CAST(@EmployeeID AS VARCHAR)
    + ' | Name: '
    + @FirstName
    + ' '
    + @LastName
    + ' | Salary: '
    + CAST(@Salary AS VARCHAR);

    FETCH NEXT FROM EmployeeCursor

    INTO

    @EmployeeID,
    @FirstName,
    @LastName,
    @DepartmentID,
    @Salary,
    @JoinDate;

END;

-- CLOSE CURSOR

CLOSE EmployeeCursor;

-- DEALLOCATE CURSOR

DEALLOCATE EmployeeCursor;
GO

-- =====================================================
-- EXERCISE 2 : STATIC CURSOR
-- =====================================================

DECLARE

    @EmpID1 INT,
    @FName1 VARCHAR(50);

DECLARE StaticCursor CURSOR STATIC

FOR

SELECT EmployeeID, FirstName
FROM Employees;

OPEN StaticCursor;

FETCH NEXT FROM StaticCursor
INTO @EmpID1, @FName1;

WHILE @@FETCH_STATUS = 0

BEGIN

    PRINT
    'STATIC CURSOR -> '
    + CAST(@EmpID1 AS VARCHAR)
    + ' '
    + @FName1;

    FETCH NEXT FROM StaticCursor
    INTO @EmpID1, @FName1;

END;

CLOSE StaticCursor;

DEALLOCATE StaticCursor;
GO

-- =====================================================
-- EXERCISE 3 : DYNAMIC CURSOR
-- =====================================================

DECLARE

    @EmpID2 INT,
    @FName2 VARCHAR(50);

DECLARE DynamicCursor CURSOR DYNAMIC

FOR

SELECT EmployeeID, FirstName
FROM Employees;

OPEN DynamicCursor;

FETCH NEXT FROM DynamicCursor
INTO @EmpID2, @FName2;

WHILE @@FETCH_STATUS = 0

BEGIN

    PRINT
    'DYNAMIC CURSOR -> '
    + CAST(@EmpID2 AS VARCHAR)
    + ' '
    + @FName2;

    FETCH NEXT FROM DynamicCursor
    INTO @EmpID2, @FName2;

END;

CLOSE DynamicCursor;

DEALLOCATE DynamicCursor;
GO

-- =====================================================
-- EXERCISE 4 : FORWARD ONLY CURSOR
-- =====================================================

DECLARE

    @EmpID3 INT,
    @FName3 VARCHAR(50);

DECLARE ForwardCursor CURSOR FORWARD_ONLY

FOR

SELECT EmployeeID, FirstName
FROM Employees;

OPEN ForwardCursor;

FETCH NEXT FROM ForwardCursor
INTO @EmpID3, @FName3;

WHILE @@FETCH_STATUS = 0

BEGIN

    PRINT
    'FORWARD CURSOR -> '
    + CAST(@EmpID3 AS VARCHAR)
    + ' '
    + @FName3;

    FETCH NEXT FROM ForwardCursor
    INTO @EmpID3, @FName3;

END;

CLOSE ForwardCursor;

DEALLOCATE ForwardCursor;
GO

-- =====================================================
-- EXERCISE 5 : KEYSET CURSOR
-- =====================================================

DECLARE

    @EmpID4 INT,
    @FName4 VARCHAR(50);

DECLARE KeysetCursor CURSOR KEYSET

FOR

SELECT EmployeeID, FirstName
FROM Employees;

OPEN KeysetCursor;

FETCH NEXT FROM KeysetCursor
INTO @EmpID4, @FName4;

WHILE @@FETCH_STATUS = 0

BEGIN

    PRINT
    'KEYSET CURSOR -> '
    + CAST(@EmpID4 AS VARCHAR)
    + ' '
    + @FName4;

    FETCH NEXT FROM KeysetCursor
    INTO @EmpID4, @FName4;

END;

CLOSE KeysetCursor;

DEALLOCATE KeysetCursor;
GO

-- =====================================================
-- COMPARISON OF CURSORS
-- =====================================================

PRINT 'STATIC CURSOR : Snapshot of data';
PRINT 'DYNAMIC CURSOR : Reflects all changes';
PRINT 'FORWARD_ONLY CURSOR : Moves only forward';
PRINT 'KEYSET CURSOR : Keys fixed, data changes visible';
GO
