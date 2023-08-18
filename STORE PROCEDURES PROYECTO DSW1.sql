USE BDALMACENELECTRO
GO
--=============================================================--             
				         --SP LOGIN--
--=============================================================--
CREATE OR ALTER PROCEDURE sp_LoginUsuario
	@nomUsuario varchar(45),
	@passUsuario varchar(45)
AS
BEGIN
	SELECT *
	FROM USUARIO
	WHERE nomUsuario = @nomUsuario
		AND passUsuario = @passUsuario
END
GO
--=============================================================--
                     --SP PARA LOS COMBOBOX
--=============================================================--
--sp_GetMarca(ok)
CREATE OR ALTER PROCEDURE sp_GetMarca
AS
BEGIN
	SELECT idMarca, nomMarca
	FROM MARCA
END
GO

--sp_GetCategoriaProducto(ok)
CREATE OR ALTER PROCEDURE sp_GetCategoriaProducto
AS
BEGIN
	SELECT idCategoria, nomCategoria
	FROM CATEGORIA_PRODUCTO
END
GO

--sp_GetCargo
CREATE OR ALTER PROCEDURE sp_GetCargo
AS
BEGIN
	SELECT idCargo, nomCargo
	FROM CARGO
END
GO

--sp_GetEstado
CREATE OR ALTER PROCEDURE sp_GetEstado
AS
BEGIN
	SELECT idEstado, nomEstado
	FROM ESTADO
END
GO

--sp_GetEmpleadosCBO
CREATE OR ALTER PROCEDURE sp_GetEmpleadosCBO
AS
BEGIN
	SELECT idEmpleado, nomEmpleado
	FROM EMPLEADO
END
GO
--=============================================================--
             --SP para los listados y CRUD por Entidad
--=============================================================--
-----------------------TABLA PRODUCTO-----------------------------
--==============================================================--

--LISTA DE PRODUCTOS
CREATE OR ALTER PROCEDURE sp_listaProductos
AS
BEGIN
	SELECT P.idProducto, P.nomProducto, M.idMarca, M.nomMarca, C.idCategoria, C.nomCategoria, P.modeloProducto, P.cantProducto
	FROM PRODUCTO P
	INNER JOIN MARCA M ON M.idMarca = P.idMarca
	INNER JOIN CATEGORIA_PRODUCTO C ON C.idCategoria = P.idCategoria
END
GO
EXEC sp_listaProductos
GO

--INSERTAR NUEVO PRODUCTO
CREATE OR ALTER PROCEDURE sp_insertProducto
	@prmNomProducto VARCHAR(45),
	@prmIdMarca INT,
	@prmModeloProducto VARCHAR(45),
	@prmCantProducto INT,
	@prmIdCategoria INT
AS
BEGIN
	INSERT INTO PRODUCTO (nomProducto, idMarca, modeloProducto, cantProducto, idCategoria)
	VALUES (@prmNomProducto, @prmIdMarca, @prmModeloProducto, @prmCantProducto, @prmIdCategoria)
END
GO

--ACTUALIZAR PRODUCTO
CREATE OR ALTER PROCEDURE sp_UpdateProducto
	@prmIdProducto INT,
	@prmNomProducto VARCHAR(45),
	@prmIdMarca INT,
	@prmModeloProducto VARCHAR(45),
	@prmCantProducto INT,
	@prmIdCategoria INT
AS
BEGIN
	UPDATE PRODUCTO
	SET
		nomProducto = @prmNomProducto,
		idMarca = @prmIdMarca,
		modeloProducto = @prmModeloProducto,
		cantProducto = @prmCantProducto,
		idCategoria = @prmIdCategoria
	WHERE idProducto = @prmIdProducto
END
GO

--BUSCAR PRODUCTO POR ID--
CREATE OR ALTER PROCEDURE sp_buscar_productoId
	@prmIdProducto INT
AS
BEGIN
	SELECT*FROM PRODUCTO WHERE idProducto = @prmIdProducto
END
GO

EXEC sp_buscar_productoId @prmIdProducto = 3
GO

--ELIMINAR PRODUCTO
CREATE OR ALTER PROCEDURE sp_EliminarProducto
	@prmIdProducto INT
AS
BEGIN
	DELETE FROM PRODUCTO WHERE idProducto = @prmIdProducto
END
GO


--------------------------------TABLA GUIA_RECEPCION----------------------------------
--==================================================================================--

--LISTA DE GUIAS
CREATE OR ALTER PROCEDURE sp_listarGuiasRecepcion
AS
BEGIN
	SELECT GR.idGuiaRecepcion, P.idProveedor,P.razonSocialProveedor, GR.fecLlegada, GR.numGuia, E.idEmpleado, E.nomEmpleado
	FROM GUIA_RECEPCION GR  
	INNER JOIN PROVEEDOR P ON P.idProveedor = GR.idProveedor
	INNER JOIN EMPLEADO E ON E.idEmpleado = GR.idEmpleado
END
GO
EXEC sp_listarGuiasRecepcion
GO

--AGREGAR GUIA
CREATE OR ALTER PROCEDURE sp_insert_guiaRecepcion
	@idProveedor INT,
	@fecLlegada VARCHAR(45),
	@numGuia VARCHAR(45),
	@idEmpleado INT
AS
BEGIN
	INSERT INTO GUIA_RECEPCION (idProveedor,fecLlegada,numGuia, idEmpleado)
	VALUES (@idProveedor, @fecLlegada, @numGuia, @idEmpleado)
END
GO

--EDITAR GUIA
CREATE OR ALTER PROCEDURE sp_update_guiaRecepcion
	@idGuiaRecepcion INT,
	@idProveedor INT,
	@fecLlegada VARCHAR(45),
	@numGuia VARCHAR(45),
	@idEmpleado INT
AS
BEGIN
	UPDATE GUIA_RECEPCION SET
	idProveedor = @idProveedor,
	fecLlegada = @fecLlegada,
	numGuia =@numGuia,
	idEmpleado = @idEmpleado
WHERE idGuiaRecepcion = @idGuiaRecepcion
END
GO
	
--BUSCAR GUIA POR ID
CREATE OR ALTER PROCEDURE sp_buscar_guiaRecepcion
	@idGuiaRecepcion INT
AS
BEGIN
	SELECT*FROM GUIA_RECEPCION WHERE idGuiaRecepcion = @idGuiaRecepcion
END
GO

--ELIMINAR GUIA
CREATE OR ALTER PROCEDURE sp_eliminar_guiaRecepcion
@idGuiaRecepcion INT
AS
BEGIN
	DELETE FROM GUIA_RECEPCION WHERE idGuiaRecepcion = @idGuiaRecepcion
END
GO

--------------------------------TABLA PROVEEDOR--------------------------------
--===========================================================================--
--LISTA DE PROVEEDORES
CREATE OR ALTER PROCEDURE sp_listar_provedores
AS
BEGIN
	SELECT P.idProveedor, P.rucProveedor, P.razonSocialProveedor,P.telefono
	FROM PROVEEDOR P  
	INNER JOIN PROVEEDOR P ON P.idProveedor = GR.idProveedor
	INNER JOIN EMPLEADO E ON E.idEmpleado = GR.idEmpleado
END
GO
EXEC sp_listarGuiasRecepcion
GO






----------------------------------TABLA USUARIO--------------------------------
--===========================================================================--

----LISTA DE USUARIOS
--CREATE OR ALTER PROCEDURE sp_listaUsuarios
--AS
--BEGIN
--	SELECT U.idUsuario, U.nomUsuario, U.passUsuario, E.idEmpleado, E.nomEmpleado
--	FROM USUARIO U  
--	INNER JOIN EMPLEADO E ON E.idEmpleado = U.idEmpleado
--END
--GO
--EXEC sp_listaUsuarios
--GO

----INSERTAR NUEVO USUARIO
--CREATE OR ALTER PROCEDURE sp_insertUsuarios
--	@prmNomUsuario VARCHAR(45),
--	@prmPassUsuario VARCHAR(45),
--	@prmIdEmpleado INT
--AS
--BEGIN
--	INSERT INTO USUARIO (nomUsuario, passUsuario, idEmpleado)
--	VALUES (@prmNomUsuario, @prmPassUsuario, @prmIdEmpleado)
--END
--GO


----ACTUALIZAR USUARIO
--CREATE OR ALTER PROCEDURE sp_UpdateUsuario
--	@prmIdUsuario INT,
--	@prmNomUsuario VARCHAR(45),
--	@prmPassUsuario VARCHAR(45),
--	@prmIdEmpleado INT
--AS
--BEGIN
--	UPDATE USUARIO
--	SET
--		nomUsuario = @prmNomUsuario,
--		passUsuario = @prmPassUsuario,
--		idEmpleado = @prmIdEmpleado
--	WHERE idUsuario = @prmIdUsuario
--END
--GO

----ELIMINAR USUARIO
--CREATE OR ALTER PROCEDURE sp_EliminarUsuario
--	@prmIdUsuario INT
--AS
--BEGIN
--	DELETE FROM USUARIO WHERE idUsuario = @prmIdUsuario
--END
--GO
----------------------------TABLA EMPLEADO--------------------------------------
--============================================================================--

----LISTA DE EMPLEADOS
--CREATE OR ALTER PROCEDURE sp_listaEmpleados
--AS
--BEGIN
--	SELECT E.idEmpleado, E.nomEmpleado, C.idCargo, C.nomCargo, E.dniEmpleado
--	FROM EMPLEADO E
--	INNER JOIN CARGO C ON C.idCargo = E.idCargo
--END
--GO
--EXEC sp_listaEmpleados
--GO

----AGREGAR EMPLEADO
--CREATE OR ALTER PROCEDURE sp_insertEmpleado
--	@prmNomEmpleado VARCHAR(45),
--	@prmIdCargo INT,
--	@prmDniEmpleado VARCHAR(45)
--AS
--BEGIN
--	INSERT INTO EMPLEADO(nomEmpleado, idCargo, dniEmpleado)
--	VALUES (@prmNomEmpleado, @prmIdCargo, @prmDniEmpleado )
--END
--GO

----EDITAR EMPLEADO
--CREATE OR ALTER PROCEDURE sp_UpdateEmpleado
--	@prmIdEmpleado INT,
--	@prmNomEmpleado VARCHAR(45),
--	@prmIdCargo INT,
--	@prmDniEmpleado VARCHAR(45)
--AS
--BEGIN
--	UPDATE EMPLEADO
--	SET
--		nomEmpleado = @prmNomEmpleado,
--		idCargo = @prmIdCargo,
--		dniEmpleado = @prmDniEmpleado
--	WHERE idEmpleado = @prmIdEmpleado
--END
--GO

----ELIMINAR EMPLEADO
--CREATE OR ALTER PROCEDURE sp_EliminarEmpleado
--	@prmIdEmpleado INT
--AS
--BEGIN
--	DELETE FROM EMPLEADO WHERE idEmpleado = @prmIdEmpleado
--END
--GO
