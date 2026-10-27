USE Northwind
EXEC sp_ObtenerProductosConDetalles;

EXEC sp_ObtenerProductosConDetalles @productID = 47;

EXEC sp_ObtenerDescuentos;

EXEC sp_ObtenerDescuentos @productID = 47;