USE NORTHWIND;
GO

--------------------------------------------------------------------------------
-- 1. CONFIGURACIÓN DE LLAVES FORÁNEAS EN CASCADA (ON DELETE CASCADE)
--------------------------------------------------------------------------------

-- Relación de Products con OrderDetails (Nombre corregido según tu BD[cite: 3])
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Order_Details_Products')
BEGIN
    ALTER TABLE Ventas.OrderDetails DROP CONSTRAINT FK_Order_Details_Products;
    ALTER TABLE Ventas.OrderDetails ADD CONSTRAINT FK_Order_Details_Products 
        FOREIGN KEY (ProductID) REFERENCES Inventario.Products(ProductID) ON DELETE CASCADE;
END
GO

-- Relación de Employees con EmployeeTerritories
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_EmployeeTerritories_Employees')
BEGIN
    ALTER TABLE RRHH.EmployeeTerritories DROP CONSTRAINT FK_EmployeeTerritories_Employees;
    ALTER TABLE RRHH.EmployeeTerritories ADD CONSTRAINT FK_EmployeeTerritories_Employees 
        FOREIGN KEY (EmployeeID) REFERENCES RRHH.Employees(EmployeeID) ON DELETE CASCADE;
END
GO

-- Relación de Employees con Orders
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Orders_Employees')
BEGIN
    ALTER TABLE Ventas.Orders DROP CONSTRAINT FK_Orders_Employees;
    ALTER TABLE Ventas.Orders ADD CONSTRAINT FK_Orders_Employees 
        FOREIGN KEY (EmployeeID) REFERENCES RRHH.Employees(EmployeeID) ON DELETE CASCADE;
END
GO

-- Relación de Shippers con Orders
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Orders_Shippers')
BEGIN
    ALTER TABLE Ventas.Orders DROP CONSTRAINT FK_Orders_Shippers;
    ALTER TABLE Ventas.Orders ADD CONSTRAINT FK_Orders_Shippers 
        FOREIGN KEY (ShipVia) REFERENCES Ventas.Shippers(ShipperID) ON DELETE CASCADE;
END
GO


--------------------------------------------------------------------------------
-- 2. PROCEDIMIENTO: spd_Products
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE spd_Products
    @ProductID INT,
    @Estado INT OUTPUT,
    @Mensaje VARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar variable de entrada (Código 400)
    IF @ProductID IS NULL OR @ProductID <= 0
    BEGIN
        SET @Estado = 400;
        SET @Mensaje = 'El ID del producto es invalido o es nulo.';
        RETURN;
    END

    -- Validar existencia de la llave primaria (Código 400)
    IF NOT EXISTS (SELECT 1 FROM Inventario.Products WHERE ProductID = @ProductID)
    BEGIN
        SET @Estado = 400;
        SET @Mensaje = 'El producto especificado no existe.';
        RETURN;
    END

    -- Bloque Transaccional
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Única instrucción DELETE (limpia la tabla principal y OrderDetails por el CASCADE)
        DELETE FROM Inventario.Products
        WHERE ProductID = @ProductID;

        COMMIT TRANSACTION;

        SET @Estado = 200;
        SET @Mensaje = 'Producto y sus dependencias eliminados exitosamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @Estado = 500;
        SET @Mensaje = 'Error al eliminar el producto: ' + ERROR_MESSAGE();
    END CATCH
END;
GO


--------------------------------------------------------------------------------
-- 3. PROCEDIMIENTO: spd_Employees
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE spd_Employees
    @EmployeeID INT,
    @Estado INT OUTPUT,
    @Mensaje VARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF @EmployeeID IS NULL OR @EmployeeID <= 0
    BEGIN
        SET @Estado = 400;
        SET @Mensaje = 'El ID del empleado es invalido o es nulo.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM RRHH.Employees WHERE EmployeeID = @EmployeeID)
    BEGIN
        SET @Estado = 400;
        SET @Mensaje = 'El empleado especificado no existe.';
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM RRHH.Employees
        WHERE EmployeeID = @EmployeeID;

        COMMIT TRANSACTION;

        SET @Estado = 200;
        SET @Mensaje = 'Empleado y sus dependencias eliminados exitosamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @Estado = 500;
        SET @Mensaje = 'Error al eliminar el empleado: ' + ERROR_MESSAGE();
    END CATCH
END;
GO


--------------------------------------------------------------------------------
-- 4. PROCEDIMIENTO: spd_Shippers
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE spd_Shippers
    @ShipperID INT,
    @Estado INT OUTPUT,
    @Mensaje VARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF @ShipperID IS NULL OR @ShipperID <= 0
    BEGIN
        SET @Estado = 400;
        SET @Mensaje = 'El ID del transportista es invalido o es nulo.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Ventas.Shippers WHERE ShipperID = @ShipperID)
    BEGIN
        SET @Estado = 400;
        SET @Mensaje = 'El transportista especificado no existe.';
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM Ventas.Shippers
        WHERE ShipperID = @ShipperID;

        COMMIT TRANSACTION;

        SET @Estado = 200;
        SET @Mensaje = 'Transportista y sus dependencias eliminados exitosamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @Estado = 500;
        SET @Mensaje = 'Error al eliminar el transportista: ' + ERROR_MESSAGE();
    END CATCH
END;
GO