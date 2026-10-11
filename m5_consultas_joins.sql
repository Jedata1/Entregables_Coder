
-- Consulta 1 - Vista base del proyecto 
-- INNER JOIN

SELECT
Cat.nombre_categoria AS categoría,
c.id_cliente,
c.nombre as cliente,
c.ciudad,
p.nombre_producto as producto,
p.id_categoria,
v.fecha_venta,
v.cantidad,
v.precio_unitario,
v.cantidad * v.precio_unitario as total_venta
FROM ventas v
INNER JOIN clientes c 
ON v.id_cliente = c.id_cliente
INNER JOIN productos p
ON p.id_producto = v.id_producto
INNER JOIN categorias cat
On p.id_categoria = Cat.id_categoria;

-- Consulta 2 - Clientes sin ventas
-- LEFT JOIN

SELECT
c.nombre,
c.fecha_registro,
c.email
FROM clientes c
LEFT JOIN ventas v
ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- Consulta 3 - Productos sin ventas
-- LEFT JOIN

SELECT
p.nombre_producto,
cat.nombre_categoria AS categoria,
p.precio
FROM productos p
INNER JOIN categorias cat
On p.id_categoria = Cat.id_categoria
LEFT JOIN ventas v
ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- Comsulta 4 - Consolidado por Canal
-- UNION ALL

SELECT 
Fecha_venta,
Cantidad * precio_unitario AS total_venta,
'Online' AS canal
FROM ventas
WHERE fecha_venta <= '2024-03-11'

UNION ALL

SELECT 
Fecha_venta,
Cantidad * precio_unitario AS total_venta,
'Presencial' AS canal
FROM ventas
WHERE fecha_venta > '2024-03-11';

