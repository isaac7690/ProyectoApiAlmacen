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
--sp_GetMarca(OK)
CREATE OR ALTER PROCEDURE sp_GetMarca
AS
BEGIN
	SELECT idMarca, nomMarca
	FROM MARCA
END
GO

--sp_GetCategoriaProducto(OK)
CREATE OR ALTER PROCEDURE sp_GetCategoriaProducto
AS
BEGIN
	SELECT idCategoria, nomCategoria
	FROM CATEGORIA_PRODUCTO
END
GO

--sp_GetCargo(OK)
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
-----------------------TABLA PRODUCTO-----------------------------OK
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
--LISTA DE PROVEEDORES--
CREATE OR ALTER PROCEDURE sp_listar_provedores
AS
BEGIN
	SELECT P.idProveedor, P.rucProveedor, P.razonSocialProveedor,P.telefono
	FROM PROVEEDOR P
END
GO
EXEC sp_listar_provedores
GO

--AGREGAR PROVEEDOR--
CREATE OR ALTER PROCEDURE sp_insert_proveedores
	@rucProveedor VARCHAR(15),
	@razonSocialProveedor VARCHAR(45),
	@telefono VARCHAR(45)
AS
BEGIN
	INSERT INTO PROVEEDOR(rucProveedor,razonSocialProveedor,telefono)
	VALUES (@rucProveedor, @razonSocialProveedor, @telefono)
END
GO

--EDITAR PROVEEDOR
CREATE OR ALTER PROCEDURE sp_update_proveedor
	@idProveedor INT,
	@rucProveedor VARCHAR(15),
	@razonSocialProveedor VARCHAR(45),
	@telefono VARCHAR(45)
AS
BEGIN
	UPDATE PROVEEDOR SET	
	rucProveedor = @rucProveedor,
	razonSocialProveedor = @razonSocialProveedor,
	telefono = @telefono
WHERE idProveedor = @idProveedor
END
GO

--BUSCAR PROVEEDOR POR ID--
CREATE OR ALTER PROCEDURE sp_buscar_proveedor
	@idProveedor INT
AS
BEGIN
	SELECT*FROM PROVEEDOR WHERE idProveedor = @idProveedor
END
GO

--ELIMINAR PROVEEDOR--
CREATE OR ALTER PROCEDURE sp_eliminar_proveedor
	@idProveedor INT
AS
BEGIN
	DELETE FROM PROVEEDOR WHERE idProveedor = @idProveedor
END
GO

----------------------------------TABLA EMPLEADO --------------------------------
--===========================================================================--
--LISTAR EMPLEADOS
CREATE OR ALTER PROCEDURE sp_listar_empleados
AS
BEGIN
	SELECT E.idEmpleado, E.nomEmpleado, C.idCargo, C.nomCargo, E.dniEmpleado
	FROM EMPLEADO E  
	INNER JOIN CARGO C ON C.idCargo = E.idCargo
END
GO
EXEC sp_listar_empleados
GO

--AGREGAR EMPLEADO
CREATE OR ALTER PROCEDURE sp_insert_empleado
	@nomEmpleado VARCHAR(15),
	@idCargo INT,
	@dniEmpleado VARCHAR(45)
AS
BEGIN
	INSERT INTO EMPLEADO(nomEmpleado,idCargo,dniEmpleado)
	VALUES (@nomEmpleado, @idCargo, @dniEmpleado)
END
GO

--ACTUALIZAR EMPLEADO
CREATE OR ALTER PROCEDURE sp_update_empleado
	@idEmpleado INT,
	@nomEmpleado VARCHAR(45),
	@idCargo INT,
	@dniEmpleado VARCHAR(45)
AS
BEGIN
	UPDATE EMPLEADO
	SET
		nomEmpleado = @nomEmpleado,
		idCargo = @idCargo,
		dniEmpleado = @dniEmpleado
	WHERE idEmpleado = @idEmpleado
END
GO

--BUSCAR EMPLEADO POR ID
CREATE OR ALTER PROCEDURE sp_buscar_empleado
	@idEmpleado INT
AS
BEGIN
	SELECT*FROM EMPLEADO WHERE idEmpleado = @idEmpleado
END
GO

--ELIMINAR EMPLEADO
CREATE OR ALTER PROCEDURE sp_eliminar_empleado
	@idEmpleado INT
AS
BEGIN
	DELETE FROM EMPLEADO WHERE idEmpleado = @idEmpleado
END
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