SELECT *

FROM (

    SELECT

        ProductID,
        MONTH(o.OrderDate)
        AS OrderMonth,

        od.Quantity

    FROM Orders o

    JOIN OrderDetails od
    ON o.OrderID = od.OrderID

) AS SourceTable

PIVOT(

    SUM(Quantity)

    FOR OrderMonth
    IN([1],[2],[3])

) AS PivotTable;