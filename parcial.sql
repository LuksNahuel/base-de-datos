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
	telefono BIGINT
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
	pais VARCHAR(50),
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
VALUES (DEFAULT, 'Ozbetich', 'Leon', 'Cajero', NULL, '1981-11-17', '2010-05-12', 'Alberdi 123', 'Cordoba', NULL, 1321, 'Argentina', NULL, NULL, NULL, NULL, NULL),
		(DEFAULT, 'Ocampos', 'Juan', 'Jefe', NULL, '1978-03-12', '2012-12-05', 'Don Bosco 1231', 'Cordoba', NULL, 1332, 'Argentina',NULL, NULL, NULL, NULL, NULL),
		(DEFAULT, 'Bonet', 'Sebastian', 'Vendedor', NULL, '1996-05-25', '2013-05-17', 'Rivadavia 45500', 'Salta', NULL, 1041, 'Argentina',NULL, NULL, NULL, NULL, NULL),
		(DEFAULT, 'Reyes', 'Emmanuel', 'Jefe', NULL, '1979-08-16', '2012-12-03', 'Avellaneda 2981', 'Salta', NULL, 1041, 'Argentina',NULL, NULL, NULL, NULL, NULL);

INSERT INTO productos
VALUES (DEFAULT, 'Pepsi', 60, 65.99),
		 (DEFAULT, 'Coca', 60, 95.25),
		 (DEFAULT, 'Papas fritas', 25, 50.30),
		 (DEFAULT, 'Chocolate', 25, 100.30);
		 
INSERT INTO companias_de_envios 
VALUES (DEFAULT, 'Correo Argentino', 08001112323),
		 (DEFAULT, 'OCA', 1123864480),
		 (DEFAULT, 'Rapido del Oeste', 08002223232),
		 (DEFAULT, 'Andreani', 08003335432);

INSERT INTO pedidos
VALUES (DEFAULT, 1, 1,1, '2019-06-12', '2019-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
		 (DEFAULT, 2, 2,2, '2019-03-10', '2019-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
		 (DEFAULT, 3, 3,2, '2019-08-03', '2019-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
		 (DEFAULT, 1, 2,3, '2019-03-03', '2019-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
		 (DEFAULT, 2, 3,4, '2019-02-08', '2019-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO detalles_pedido
VALUES (1,1, 45.43, 120, 5),
		 (1, 2, 32.23, 100, 5),
		 (1, 3,20.25, 200, 10),
		 (2, 2, 10.40, 50, 5),
		 (3, 4, 100.00, 70, 10);
		 

-- a)
SELECT PROD.nombre_producto AS "Producto", PROD.cantidad_por_unidad AS "Cantidad", C.nombre_contacto AS "Nombre cliente", C.cargo_contacto AS "Cargo cliente", C.pais AS "Cliente pais", E.apellido AS "Empleado apellido", E.nombre AS "Empleado nombre", E.cargo AS "Empleado cargo", E.ciudad AS "Empleado ciudad", E.pais AS "Emplaedo pais"
FROM pedidos AS P
INNER JOIN clientes AS C
ON P.id_cliente = C.id_cliente
INNER JOIN empleados AS E
ON E.id_empleado = P.id_empleado
INNER JOIN detalles_pedido AS D
ON D.id_pedido = P.id_pedido
INNER JOIN productos AS PROD
ON PROD.id_producto = D.id_producto 
GROUP BY C.ciudad
ORDER BY C.ciudad DESC;

SELECT *
FROM pedidos;

-- b)

SELECT empleados.ciudad, clientes.nombre_compania, clientes.nombre_contacto, clientes.apellido_contacto, clientes.cargo_contacto, clientes.ciudad
FROM clientes
INNER JOIN pedidos
ON pedidos.id_cliente = clientes.id_cliente
INNER JOIN empleados
ON empleados.id_empleado = pedidos.id_empleado
WHERE clientes.ciudad = 'Mendoza' AND empleados.ciudad = 'Cordoba';


-- b1)

SELECT *
FROM empleados;

UPDATE empleados
SET cod_postal = 'AA15236'
WHERE empleados.ciudad = 'Salta' AND empleados.cargo LIKE 'J%' AND (empleados.fecha_nacimiento > '1956-01-01' AND empleados.fecha_nacimiento < '1982-01-01');

-- c)

SELECT C.nombre_contacto AS "Nombre cliente", C.apellido_contacto AS "Apellido cliente", P.fecha_pedido AS "Fecha pedido", P.id_pedido AS "ID Pedido", PROD.nombre_producto AS "Nombre producto", D.cantidad AS "Cantidad producto", PROD.precio_unidad AS "Precio unidad", (PROD.precio_unidad * D.cantidad) AS "Total", E.nombre AS "Empleado"
FROM pedidos AS P
INNER JOIN clientes AS C
ON P.id_cliente = C.id_cliente
INNER JOIN companias_de_envios AS COMP
ON COMP.id_compania = P.id_compania
INNER JOIN detalles_pedido AS D
ON D.id_pedido = P.id_pedido
INNER JOIN productos AS PROD
ON D.id_producto = PROD.id_producto
INNER JOIN empleados AS E
ON P.id_empleado = E.id_empleado
GROUP BY P.id_pedido;

-- d)

SELECT C.nombre_contacto AS "Nombre cliente", C.ciudad AS "Ciudad cliente", P.fecha_pedido AS "Fecha pedido"
FROM pedidos AS P
INNER JOIN clientes AS C
ON P.id_cliente = C.id_cliente
INNER JOIN companias_de_envios AS COMP
ON COMP.id_compania = P.id_compania
INNER JOIN detalles_pedido AS D
ON D.id_pedido = P.id_pedido
INNER JOIN productos AS PROD
ON D.id_producto = PROD.id_producto
INNER JOIN empleados AS E
ON P.id_empleado = E.id_empleado
GROUP BY P.id_pedido;
