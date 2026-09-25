
USE Ventas_Tech_DB;

-- TABLA VENTAS

-- Consulta 1 Resumen ejecutivo mensual
--Total facturado, cantidad pedidos, ticket promedio por mes 

SELECT
MONTH (fecha_venta) AS mes,
SUM (cantidad * precio_unitario) AS total_facturado,
COUNT (cantidad) AS cantidad_pedidos,
AVG (cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH (fecha_venta) ORDER BY MONTH (fecha_venta) ASC;


-- Consulta 2 Ranking de productos Top 5
-- id_producto por total facturado y unidades vendidas

SELECT TOP 5 
id_producto,
SUM (cantidad) AS unidades_vendidas,
SUM (cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto ORDER BY total_facturado DESC;

-- Consulta 3 Clientes recurrentes
-- Clientes con más de un pedido, cantidad de pedidos y el total gastado

SELECT
id_cliente,
COUNT(*) AS cantidad_pedidos,
SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente HAVING COUNT (*) > 1;

-- Consulta 4 Meses por encima/por debajo del promedio
-- Total facturado por mes con "por encima" o "por debajo" del promedio mensual

WITH Ventas_Mensuales AS (
SELECT 
MONTH(fecha_venta) AS mes, 
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas 
GROUP BY MONTH(fecha_venta)
),
Ventas_Promedio AS (
SELECT 
mes,
total_facturado,
AVG(total_facturado) OVER() AS promedio_mensual,
CASE 
WHEN total_facturado >= AVG(total_facturado) OVER() THEN 'Por encima' 
ELSE 'Por debajo' 
END AS promedio_mensual_general
FROM Ventas_Mensuales
)
SELECT * 
FROM Ventas_Promedio
ORDER BY mes ASC;

-- Bloque de cierre --
--1) id_producto 1; menor cantidad unidades vendidas/ mayor facturación.
--2) id_producto 2; mayor cantidad unidades vendidas / menor facturación.
--3) id_cliente 1; cliente recurrente con mayor gasto acumulado.
--4) Todas las ventas transcurren en el mes 3 (marzo) con un total facturado de 6.444,00 quedando por encima del promedio mensual.

