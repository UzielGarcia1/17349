ALTER PROCEDURE sp_ObtenerProductosConDetalles
    @productID INT = NULL
AS
BEGIN
    SELECT 
        p.ProductID,
        p.ProductName,
        c.CategoryName,
        od.Quantity,
        od.UnitPrice
    FROM 
        Inventario.Products p
    INNER JOIN 
        Inventario.Categories c ON p.CategoryID = c.CategoryID
    INNER JOIN 
        Ventas.OrderDetails od ON p.ProductID = od.ProductID
    WHERE 
        p.ProductID = ISNULL(@productID, p.ProductID)
    ORDER BY 
        p.ProductName DESC;
END;
GO


ALTER PROCEDURE sp_ObtenerDescuentos
    @productID INT = NULL
AS
BEGIN
    SELECT 
        cust.CustomerID,
        cust.CompanyName,
        o.OrderID,
        p.ProductName,
        od.Quantity,
        od.UnitPrice,
        od.Discount
    FROM 
        Ventas.Customers cust
    INNER JOIN 
        Ventas.Orders o ON cust.CustomerID = o.CustomerID
    INNER JOIN 
        ventas.OrderDetails od ON o.OrderID = od.OrderID
    INNER JOIN 
        Inventario.Products p ON od.ProductID = p.ProductID
    WHERE 
        p.ProductID = ISNULL(@productID, p.ProductID)
    ORDER BY 
        cust.CompanyName ASC, 
        o.OrderID ASC;
END;

