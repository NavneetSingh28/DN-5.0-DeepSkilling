WITH CustomerOrderCounts AS (

    SELECT

        o.CustomerID,
        COUNT(o.OrderID)
        AS OrderCount

    FROM Orders o

    GROUP BY o.CustomerID
)

SELECT

    c.CustomerID,
    c.Name,
    coc.OrderCount

FROM CustomerOrderCounts coc

JOIN Customers c
ON c.CustomerID = coc.CustomerID

WHERE coc.OrderCount > 1;