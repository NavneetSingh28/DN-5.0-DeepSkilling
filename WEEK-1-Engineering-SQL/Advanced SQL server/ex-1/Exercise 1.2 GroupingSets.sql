SELECT

    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity

FROM Orders o

JOIN Customers c
ON o.CustomerID = c.CustomerID

JOIN OrderDetails od
ON o.OrderID = od.OrderID

JOIN Products p
ON od.ProductID = p.ProductID

GROUP BY GROUPING SETS (

    (c.Region,p.Category),
    (c.Region),
    (p.Category)
);

SELECT

    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity

FROM Orders o

JOIN Customers c
ON o.CustomerID = c.CustomerID

JOIN OrderDetails od
ON o.OrderID = od.OrderID

JOIN Products p
ON od.ProductID = p.ProductID

GROUP BY ROLLUP(c.Region,p.Category);

SELECT

    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity

FROM Orders o

JOIN Customers c
ON o.CustomerID = c.CustomerID

JOIN OrderDetails od
ON o.OrderID = od.OrderID

JOIN Products p
ON od.ProductID = p.ProductID

GROUP BY CUBE(c.Region,p.Category);