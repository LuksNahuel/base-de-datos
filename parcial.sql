DROP DATABASE IF EXISTS parcial;
CREATE DATABASE IF NOT EXISTS parcial;
USE parcial;

CREATE TABLE IF NOT EXISTS clientes (
	id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre_compania VARCHAR(50),
	nombre_contacto VARCHAR(50),
	apellido_contacto VARCHAR(50),
	cargo_contacto VARCHAR(50),
	direccion VARCHAR(80),
	ciudad VARCHAR(50),
	region VARCHAR(50),
	cod_postal VARCHAR(50),
	pais VARCHAR(50),
	telefono INT,
	fax INT
);

CREATE TABLE IF NOT EXISTS companias_de_envios (
	id_compania INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre_compania VARCHAR(50),
	telefono INT
);

CREATE TABLE IF NOT EXISTS productos (
	id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre_producto VARCHAR(50),
	cantidad_por_unidad SMALLINT,
	precio_unidad DECIMAL(15,2)
);

CREATE TABLE IF NOT EXISTS empleados (
	id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	apellido VARCHAR(50),
	nombre VARCHAR(50),
	cargo VARCHAR(50),
	tratamiento VARCHAR(50),
	fecha_nacimiento DATE,
	fecha_contratacion DATE,
	direccion VARCHAR(80),
	ciudad VARCHAR(50),
	region VARCHAR(50),
	cod_postal VARCHAR(50),
	tel_domicilio INT,
	extension INT,
	foto TEXT,
	notas VARCHAR(80),
	jefe VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS pedidos (
	id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_cliente INT NOT NULL,
	id_empleado INT NOT NULL,
	id_compania INT NOT NULL,
	fecha_pedido DATE,
	fecha_entrega DATE,
	forma_envio TEXT,
	cargo DECIMAL(15,2),
	destinatario VARCHAR(50),
	direccion_destinatario VARCHAR(80),
	ciudad_destinatario VARCHAR(50),
	region_destinatario VARCHAR(50),
	cod_postal_destinatario VARCHAR(50),
	pais_destinatario VARCHAR(50),
	CONSTRAINT FK_id_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
	CONSTRAINT FK_id_empleado FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
	CONSTRAINT FK_id_compania FOREIGN KEY (id_compania) REFERENCES companias_de_envios(id_compania)
);

CREATE TABLE IF NOT EXISTS detalles_pedido (
	id_pedido INT NOT NULL,
	id_producto INT NOT NULL,
	precio_unidad DECIMAL(15,2),
	cantidad SMALLINT,
	descuento SMALLINT,
	CONSTRAINT FK_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
	CONSTRAINT FK_id_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

	
INSERT INTO clientes 
VALUES (DEFAULT, 'Pepsico', 'Hugo', 'Pared', 'Vendedor', 'Rios Gallardo 695', 'Mendoza', NULL, 1708, 'Argentina', 1133445566, NULL),
		(DEFAULT, 'Coca-Cola', 'Ivan', 'Pared', 'Repartidor', NULL, 'Mendoza', NULL, 1708, 'Argentina', 1123864480, NULL),
		(DEFAULT, 'Manaos', 'Juan', 'Alberdi', 'Representante de ventas', NULL, 'Mendoza', NULL, 1321, 'Argentina', 1132674533, NULL);
		
INSERT INTO empleados
VALUES (DEFAULT, 'Ozbetich', 'Leon', 'Cajero', NULL, '1995-11-17', '2010-05-12', 'Alberdi 123', 'Cordoba', NULL, 1321, 'Argentina', NULL, NULL, NULL, NULL, NULL),
		(DEFAULT, 'Ocampos', 'Juan', 'Contador', NULL, '1996-03-12', '2012-12-05', 'Don Bosco 1231', 'Cordoba', NULL, 1332, 'Argentina',NULL, NULL, NULL, NULL, NULL),
		(DEFAULT, 'Bonet', 'Sebastian', 'Vendedor', NULL, '1996-05-25', '2013-05-17', 'Rivadavia 45500', 'Salta', NULL, 1041, 'Argentina',NULL, NULL, NULL, NULL, NULL),
		(DEFAULT, 'Reyes', 'Emmanuel', 'Vendedor', NULL, '1995-08-16', '2012-12-03', 'Avellaneda 2981', 'Salta', NULL, 1041, 'Argentina',NULL, NULL, NULL, NULL, NULL);

