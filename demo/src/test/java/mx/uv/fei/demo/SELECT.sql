SELECT
ProductID,
ProductName,
UnitPrice,
UnitsInStock,
dbo.calculate_total_price(UnitPrice, UnitsInStock) AS TotalPrice
FROM Inventario.Products;