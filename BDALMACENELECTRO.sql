USE MASTER
GO

IF DB_ID ('BDALMACENELECTRO') IS NOT NULL
DROP DATABASE BDALMACENELECTRO
GO

CREATE DATABASE BDALMACENELECTRO
GO

USE BDALMACENELECTRO
GO

SET NOCOUNT OFF
GO
SELECT 'Base de Datos BDALMACENELECTRO creada correctamente' AS MENSAJE
GO
PRINT 'Base de Datos BDALMACENELECTRO creada correctamente'
GO


--===========================================================================================
--CREACIÓN DE TABLAS--
--===========================================================================================

CREATE TABLE CARGO(
idCargo INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nomCargo VARCHAR (45) NOT NULL)
GO

CREATE TABLE MARCA(
idMarca INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nomMarca VARCHAR (45) NOT NULL)
GO

CREATE TABLE ESTADO(
idEstado INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nomEstado VARCHAR (45) NOT NULL)
GO

CREATE TABLE CATEGORIA_PRODUCTO(
idCategoria INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nomCategoria VARCHAR (45) NOT NULL)
GO

CREATE TABLE TIENDA(
idTienda INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nomTienda VARCHAR (45) NOT NULL,
dirTienda VARCHAR (45) NOT NULL)
GO

CREATE TABLE EMPRESA_TRANSPORTE(
idEmpresaTransporte INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
razonSocialTansporte VARCHAR (45),
rucTransporte VARCHAR (15) NOT NULL)
GO

CREATE TABLE PROVEEDOR(
idProveedor INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
rucProveedor VARCHAR (15) NOT NULL,
razonSocialProveedor VARCHAR (45) NOT NULL,
telefono VARCHAR (45) NOT NULL)
GO

CREATE TABLE PRODUCTO(
idProducto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nomProducto VARCHAR (45) NOT NULL,
idMarca INT NOT NULL REFERENCES MARCA,
modeloProducto VARCHAR (45) NOT NULL,
cantProducto INT NOT NULL,
idCategoria INT NOT NULL REFERENCES CATEGORIA_PRODUCTO)
GO

CREATE TABLE EMPLEADO(
idEmpleado INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nomEmpleado VARCHAR (45) NOT NULL,
idCargo INT NOT NULL REFERENCES CARGO,
dniEmpleado VARCHAR (45) NOT NULL)
GO

CREATE TABLE USUARIO(
idUsuario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nomUsuario VARCHAR (45) NOT NULL,
passUsuario VARCHAR (45) NOT NULL,
idEmpleado INT NOT NULL REFERENCES EMPLEADO)
GO

CREATE TABLE GUIA_RECEPCION(
idGuiaRecepcion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idProveedor INT NOT NULL REFERENCES PROVEEDOR,
fecLlegada VARCHAR(45) NOT NULL,
numGuia VARCHAR (45) NOT NULL,
idEmpleado INT NOT NULL REFERENCES EMPLEADO)
GO

CREATE TABLE DETALLE_RECEPCION(
idDetRecepcion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idGuiaRecepcion INT NOT NULL REFERENCES GUIA_RECEPCION,
idProducto INT NOT NULL REFERENCES PRODUCTO,
cantidad INT NOT NULL)
GO

CREATE TABLE UNIDAD_TRANSPORTE(
idUnidadTransporte INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idEmpresaTransporte INT NOT NULL REFERENCES EMPRESA_TRANSPORTE,
placaUnidadTransporte VARCHAR(10) NOT NULL)
GO

CREATE TABLE GUIA_ENVIO(
idGuiaEnvio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idTienda INT NOT NULL REFERENCES TIENDA,
idUnidadTransporte INT NOT NULL REFERENCES UNIDAD_TRANSPORTE,
idEmpleado INT NOT NULL REFERENCES EMPLEADO,
numGuia VARCHAR (45) NOT NULL,
fecEnvio VARCHAR(45) NOT NULL,
fecEntrega VARCHAR(45) NOT NULL,
idEstado INT NOT NULL REFERENCES ESTADO)
GO

CREATE TABLE DETALLE_ENVIO(
idDetEnvio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idGuiaEnvio INT NOT NULL REFERENCES GUIA_ENVIO,
idProducto INT NOT NULL REFERENCES PRODUCTO,
cantidad INT NOT NULL)
GO
 

SET NOCOUNT OFF
GO
SELECT 'Tablas creadas correctamente' AS MENSAJE
GO
PRINT 'Tablas creadas correctamente'
GO

--===========================================================================================
--CREACIÓN DE REGISTROS--
--===========================================================================================

--CARGO-ok
INSERT INTO CARGO VALUES ('admin')
INSERT INTO CARGO VALUES ('jefe de almacen')
INSERT INTO CARGO VALUES ('ayudante de almacen')
GO

--MARCA-OK
INSERT INTO MARCA VALUES ('LG')
INSERT INTO MARCA VALUES ('SAMSUNG')
INSERT INTO MARCA VALUES ('BOSCH')
INSERT INTO MARCA VALUES ('ELECTROLUX')
GO

--ESTADO-ok
INSERT INTO ESTADO VALUES ('despachado')
INSERT INTO ESTADO VALUES ('entregado')
GO

--CATEGORIA_PRODUCTO-ok (creo que se podrían cambiar estos datos y las cat. se llamarían como se maneja actualmente en tiendas: linea blanca, computo, accesorios, audio/video, telefonía, televisores, etc)
INSERT INTO CATEGORIA_PRODUCTO VALUES ('linea blanca') --cocina, limpieza, lavadoras, aire acondicionado.
INSERT INTO CATEGORIA_PRODUCTO VALUES ('linea gris') -- impresoras, accesorios para celulares, accesorios de cómputo
INSERT INTO CATEGORIA_PRODUCTO VALUES ('linea marron') -- televisores, reproductores de audio/video, pc/laptops, telefonía, tablets
GO

--TIENDA -ok
INSERT INTO TIENDA VALUES ('METRO INDEPENDENCIA','Av. Alfredo Mendiola 3900')
INSERT INTO TIENDA VALUES ('METRO CALLAO','Calle 3 Pabellón 9 Centro Comercial Minka')
INSERT INTO TIENDA VALUES ('METRO COMAS','Av. Túpac Amaru Km. 3.5, Urb. La Pascana,')
INSERT INTO TIENDA VALUES ('METRO SAN MIGUEL','Av. La Marina cdra. 25')
INSERT INTO TIENDA VALUES ('METRO BREÑA','Esq. Av. Venezuela con Av. Alfonso Ugarte,')
INSERT INTO TIENDA VALUES ('METRO VENTANILLA','Av. Néstor Gambeta s/n')
GO

--EMPRESA_TRANSPORTE-ok
INSERT INTO EMPRESA_TRANSPORTE VALUES ('Timco SAC','20602034004')
INSERT INTO EMPRESA_TRANSPORTE VALUES ('Transportes Logísticos y Carga EIRL','20545361940')
INSERT INTO EMPRESA_TRANSPORTE VALUES ('Transportes 77 SA','20100015103')
INSERT INTO EMPRESA_TRANSPORTE VALUES ('Empresa de Transportes Diaz SRL','20373756912')
GO

--PROVEEDOR-ok
INSERT INTO PROVEEDOR VALUES ('20300263578','Samsung Electronics Perú SAC','4098981')
INSERT INTO PROVEEDOR VALUES ('20375755344','LG Electronics Perú SA','4180900')
INSERT INTO PROVEEDOR VALUES ('20524506166','Robert Bosch SAC','2190332')
INSERT INTO PROVEEDOR VALUES ('20100073308','Electrolux del Perú SA','080021550')
GO

--PRODUCTO-ok
INSERT INTO PRODUCTO VALUES ('Refrigeradora 355L door cooling plata',1,'GT33BPP.APZGLPR',100,1)
INSERT INTO PRODUCTO VALUES ('Refrigeradora 617L door hygiene fresh plata',1,'LS66SPP',100,1)
INSERT INTO PRODUCTO VALUES ('Refrigeradora 318L top freezer inox',2,'RT32K5730S8',100,1)
INSERT INTO PRODUCTO VALUES ('Refrigeradora 638L side digital inverter',2,'RS64T5B00B1/PE',100,1)
INSERT INTO PRODUCTO VALUES ('Refrigeradora 318L no frost',3,'KDD30NL201',100,1)
INSERT INTO PRODUCTO VALUES ('Refrigeradora 619L inox antihuellas',3,'KGN86AI40B',100,1)
INSERT INTO PRODUCTO VALUES ('Refrigeradora 475L no frost negro',4,'IB54B',100,1)
INSERT INTO PRODUCTO VALUES ('Refrigeradora 310L frost',4,'ERT45G2HQI',100,1)
GO

--EMPLEADO-ok
INSERT INTO EMPLEADO VALUES ('Isaac Garcia',1,'46345706')
GO

--USUARIO-OK
INSERT INTO USUARIO VALUES ('admin','123456',1)
GO

--UNIDAD_TRANPORTE-OK
INSERT INTO UNIDAD_TRANSPORTE VALUES (1,'ASB-879')
INSERT INTO UNIDAD_TRANSPORTE VALUES (2,'AY5-725')
INSERT INTO UNIDAD_TRANSPORTE VALUES (3,'T3N-610')
INSERT INTO UNIDAD_TRANSPORTE VALUES (4,'T3J-404')
GO

--RECEPCION (datos se deberían rellenar en el app durante las pruebas?)
--INSERT INTO RECEPCION VALUES ()
--GO

--DETALLE_RECEPCION (datos se deberían rellenar en el app durante las pruebas?)
--INSERT INTO DETALLE_RECEPCION VALUES ()
--GO

--ENVIO (datos se deberían rellenar en el app durante las pruebas?)
--INSERT INTO ENVIO VALUES ()
--GO

--DETALLE_ENVIO (datos se deberían rellenar en el app durante las pruebas?)
--INSERT INTO DETALLE_ENVIO VALUES ()
--GO
SET NOCOUNT OFF
GO
SELECT 'Datos registrados correctamente' AS MENSAJE
GO
PRINT 'Datos registrados correctamente'
GO


