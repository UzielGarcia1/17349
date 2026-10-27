ALTER FUNCTION calculate_total_price (
    @productID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @result DECIMAL(10, 2)
    DECLARE @unit_price DECIMAL(10, 2)
    DECLARE @units_in_stock INT

    SELECT 
    @unit_price = UnitPrice,
    @units_in_stock = UnitsInStock 
    FROM Inventario.Products
    WHERE ProductID = @product_id;

    SET @result = @unit_price * @units_in_stock

    RETURN @result
END