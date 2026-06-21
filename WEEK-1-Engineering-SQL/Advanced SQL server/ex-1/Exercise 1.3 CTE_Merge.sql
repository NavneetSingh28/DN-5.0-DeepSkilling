WITH CalendarDates AS (

    SELECT
    CAST('2025-01-01' AS DATE)
    AS DateValue

    UNION ALL

    SELECT
    DATEADD(DAY,1,DateValue)

    FROM CalendarDates

    WHERE DateValue < '2025-01-31'
)

SELECT *
FROM CalendarDates

OPTION(MAXRECURSION 31);




INSERT INTO StagingProducts VALUES

(1,'Laptop','Electronics',90000),

(6,'Tablet','Electronics',25000);

DELETE FROM StagingProducts;
INSERT INTO StagingProducts VALUES

(1,'Laptop','Electronics',90000),

(6,'Tablet','Electronics',25000);

SELECT * FROM StagingProducts;

MERGE Products AS Target

USING StagingProducts AS Source

ON Target.ProductID = Source.ProductID

WHEN MATCHED THEN

UPDATE SET
    Target.Price = Source.Price

WHEN NOT MATCHED THEN

INSERT(
    ProductID,
    ProductName,
    Category,
    Price
)

VALUES(
    Source.ProductID,
    Source.ProductName,
    Source.Category,
    Source.Price
);

SELECT * FROM Products;