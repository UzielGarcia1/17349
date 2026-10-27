USE NORTHWIND;
GO

--Products
DECLARE @EstadoRes INT;
DECLARE @MensajeRes VARCHAR(250);

--Producto Inexistente
EXEC spd_Products 
    @ProductID = 9999, 
    @Estado = @EstadoRes OUTPUT, 
    @Mensaje = @MensajeRes OUTPUT;

SELECT @EstadoRes AS Estado, @MensajeRes AS Mensaje;



DECLARE @EstadoRes INT;
DECLARE @MensajeRes VARCHAR(250);
--Producto Válido (Debe dar Estado 200) ---';

EXEC spd_Products 
    @ProductID = 1, 
    @Estado = @EstadoRes OUTPUT, 
    @Mensaje = @MensajeRes OUTPUT;

SELECT @EstadoRes AS Estado, @MensajeRes AS Mensaje;
GO


--Employees
DECLARE @EstadoRes INT;
DECLARE @MensajeRes VARCHAR(250);

--Empleado Inexistente
EXEC spd_Employees 
    @EmployeeID = 999, 
    @Estado = @EstadoRes OUTPUT, 
    @Mensaje = @MensajeRes OUTPUT;

SELECT @EstadoRes AS Estado, @MensajeRes AS Mensaje;


--Empleado Valido
EXEC spd_Employees 
    @EmployeeID = 9, 
    @Estado = @EstadoRes OUTPUT, 
    @Mensaje = @MensajeRes OUTPUT;

SELECT @EstadoRes AS Estado, @MensajeRes AS Mensaje;
GO


--shippers
DECLARE @EstadoRes INT;
DECLARE @MensajeRes VARCHAR(250);

--Transportista inexistente
EXEC spd_Shippers 
    @ShipperID = 999, 
    @Estado = @EstadoRes OUTPUT, 
    @Mensaje = @MensajeRes OUTPUT;

SELECT @EstadoRes AS Estado, @MensajeRes AS Mensaje;



DECLARE @EstadoRes INT;
DECLARE @MensajeRes VARCHAR(250);

--Transportista valido

EXEC spd_Shippers 
    @ShipperID = 1, 
    @Estado = @EstadoRes OUTPUT, 
    @Mensaje = @MensajeRes OUTPUT;

SELECT @EstadoRes AS Estado, @MensajeRes AS Mensaje;
GO

 