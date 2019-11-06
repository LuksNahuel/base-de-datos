-- -- -- -- 2.1 -- -- -- --

SELECT cliente.nombre AS "nombre cliente", cliente.dni,factura.cod_factura AS "numero de factura", factura.fecha_factura AS "fecha factura", factura.total,
		 producto.marca AS "producto marca", producto.vencimiento AS "producto fecha vencimiento", vendedor.nombre AS "nombre vendedor", 
		 medio_pago.tipo AS "medio de pago"
FROM cliente
INNER JOIN factura
ON cliente.cod_cliente = factura.cod_cliente
INNER JOIN detalle_factura
ON detalle_factura.cod_factura = factura.cod_factura
INNER JOIN producto
ON detalle_factura.cod_producto = producto.cod_producto
INNER JOIN vendedor
ON factura.cod_vendedor = vendedor.cod_vendedor
INNER JOIN medio_pago
ON medio_pago.cod_cliente = cliente.cod_cliente
ORDER BY factura.cod_factura;
-- detalle factura


-- -- -- -- 2.2 -- -- -- -- -- 


SELECT cliente.nombre AS "nombre cliente", cliente.dni, factura.fecha_factura AS "fecha factura", MAX(factura.total), producto.marca AS "producto marca", 
		producto.vencimiento AS "producto fecha vencimiento", vendedor.nombre AS "nombre vendedor", medio_pago.tipo AS "medio de pago"
FROM cliente
INNER JOIN factura
ON cliente.cod_cliente = factura.cod_cliente
INNER JOIN detalle_factura
ON detalle_factura.cod_factura = factura.cod_factura
INNER JOIN producto
ON detalle_factura.cod_producto = producto.cod_producto
INNER JOIN vendedor
ON factura.cod_vendedor = vendedor.cod_vendedor
INNER JOIN medio_pago
ON medio_pago.cod_cliente = cliente.cod_cliente
WHERE medio_pago.tipo = "credito";

-- -- -- -- 2.3 -- -- -- -- --


SELECT cliente.nombre AS "nombre cliente", cliente.dni, factura.fecha_factura AS "fecha factura", factura.total * 0.5 AS "total con descuento", producto.marca AS "producto marca", 
		producto.vencimiento AS "producto fecha vencimiento", vendedor.nombre AS "nombre vendedor", medio_pago.tipo AS "medio de pago"
FROM cliente
INNER JOIN factura
ON cliente.cod_cliente = factura.cod_cliente
INNER JOIN detalle_factura
ON detalle_factura.cod_factura = factura.cod_factura
INNER JOIN producto
ON detalle_factura.cod_producto = producto.cod_producto
INNER JOIN vendedor
ON factura.cod_vendedor = vendedor.cod_vendedor
INNER JOIN medio_pago
ON medio_pago.cod_cliente = cliente.cod_cliente
WHERE medio_pago.tipo = "efectivo";


-- -- -- -- 2.4 -- -- -- --

SELECT COUNT(*)
FROM producto;

-- -- -- -- 2.5 -- -- -- --

SELECT AVG(factura.total) AS "promedio en ventas"
FROM factura;


-- -- -- -- 2.6 -- -- -- --

SELECT SUM(factura.total) AS "suma ventas"
FROM factura;



