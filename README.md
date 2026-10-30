RetailPro | Análisis de ventas y negocio con SQL Server y Power BI

Proyecto de análisis de datos comerciales para transformar información de ventas en indicadores de negocio y facilitar la toma de decisiones.

![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-CC2927?logo=microsoftsqlserver&logoColor=white) ![Power BI](https://img.shields.io/badge/Power%20BI-Data%20Visualization-F2C811?logo=powerbi&logoColor=black) ![GitHub](https://img.shields.io/badge/Repository-GitHub-181717?logo=github&logoColor=white)

Descripción del proyecto

RetailPro es un proyecto de análisis de datos orientado al sector retail, desarrollado para explorar el comportamiento de las ventas, evaluar el desempeño de los productos y clientes, y generar información útil para la gestión comercial.

El proyecto utiliza Microsoft SQL Server para modelar y consultar los datos mediante SQL y Power BI para desarrollar análisis y visualizaciones a partir de los archivos de trabajo incluidos en el repositorio.

La solución parte de una base de datos relacional que integra información de ventas, clientes, productos y categorías. Sobre esta estructura se construyen consultas que permiten calcular indicadores comerciales, identificar patrones de compra y detectar oportunidades de mejora.

Objetivos
Diseñar y consultar una base de datos relacional para gestionar información comercial.
Analizar la facturación y el volumen de pedidos por período.
Identificar los productos con mayor facturación y cantidad de unidades vendidas.
Detectar clientes recurrentes y evaluar su contribución económica.
Comparar los resultados mensuales con el promedio de facturación.
Integrar consultas SQL y visualizaciones de Power BI para comunicar hallazgos de negocio.
Herramientas y tecnologías
Herramienta	Aplicación en el proyecto
Microsoft SQL Server	Creación y gestión de la base de datos relacional.
T-SQL	Definición de tablas, carga de datos y consultas analíticas.
SQL Server Management Studio (SSMS)	Entorno recomendado para ejecutar y validar los scripts SQL.
Microsoft Power BI Desktop	Visualización y análisis de información mediante archivos .pbix.
Git y GitHub	Control de versiones, almacenamiento y documentación del proyecto.
Estructura del repositorio

Los archivos principales disponibles son:

text
Entregables_Coder/
├── SQLQuery3.sql
├── m4_consultas_negocio.sql
├── m5_consultas_joins.sql
├── Bentivenga_Jessica_Checkpoint2.pbix
├── Pipeline_ETL_Bentivenga_Jessica.pbix
└── README.md

Descripción de los archivos
SQLQuery3.sql: script de creación de la base de datos Ventas_Tech_DB, definición de tablas, relaciones y carga de datos de ejemplo.
m4_consultas_negocio.sql: consultas de análisis comercial, indicadores mensuales, ranking de productos, clientes recurrentes y comparación con el promedio de facturación.
m5_consultas_joins.sql: Consultas que relacionan las tablas del modelo mediante operaciones JOIN obteniendo información de clientes/productos sin ventas y el consolidado de ventas por canal. 
Bentivenga_Jessica_Checkpoint2.pbix: Formulas DAX Dim_Fechas; Total Ventas; Ventas Online; Ventas YTD; Ventas LY; % Crecimiento Anual. Mediante las cuales se podrá visualizar datos por año, trimestre, mes o semana, total general de ingresos, el rendimiento específico de las ventas online, ventas acumuladas durante el año en curso, comparación de ventas en distintos períodos y el porcentaje de crecimiento anual respectivamente.
Pipeline_ETL_Bentivenga_Jessica.pbix: Limpieza, calidad y modelado de la base de datos inicial. Detección y evaluación de valores nulos, vacíos, errores y registros duplicados. Revisión de formatos y nomenclaturas. Y por último tabla de ventas unificada aplicando Merge.
README.md: documentación general, instrucciones de ejecución y descripción del análisis.
Modelo de datos

La base de datos Ventas_Tech_DB contiene cuatro tablas principales:

Tabla	Descripción	Campos relevantes
categorias	Clasificación de los productos.	id_categoria, nombre_categoria, descripcion
clientes	Datos identificatorios y de registro de los clientes.	id_cliente, nombre, email, ciudad, fecha_registro
productos	Catálogo de productos, precios y existencias.	id_producto, nombre_producto, id_categoria, precio, stock, activo
ventas	Operaciones comerciales registradas.	id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta
Relaciones entre las tablas
productos.id_categoria referencia a categorias.id_categoria.
ventas.id_cliente referencia a clientes.id_cliente.
ventas.id_producto referencia a productos.id_producto.

Estas relaciones permiten combinar información transaccional con datos descriptivos para obtener una visión integral del negocio.

Análisis y consultas SQL

Los scripts contemplan diferentes necesidades de análisis comercial.

1. Resumen ejecutivo mensual

Calcula la facturación, la cantidad de registros de venta y el ticket promedio por mes.

sql
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


Indicadores obtenidos:

Total facturado.
Cantidad de registros de venta.
Ticket promedio por registro.
Nota: en el modelo actual, cada fila de ventas representa una operación identificada por id_venta. Si un pedido puede contener varias líneas, será necesario distinguir el número de pedidos del número de registros para calcular el ticket promedio por pedido correctamente.
2. Ranking de productos Top 5

Identifica los cinco productos con mayor facturación y muestra también las unidades vendidas.

sql
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


Esta consulta permite distinguir entre los productos que generan mayores ingresos y aquellos que presentan mayor volumen de unidades vendidas.

3. Clientes recurrentes

Identifica clientes con más de una operación registrada y calcula su gasto acumulado.

sql
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


El resultado facilita la identificación de clientes frecuentes y permite orientar acciones de fidelización comercial.

4. Comparación con el promedio mensual

Utiliza expresiones de tabla comunes (CTE) y funciones de ventana para comparar la facturación mensual con el promedio de los meses analizados.

Este análisis ayuda a identificar períodos de mejor o menor desempeño relativo.

5. Consultas con JOIN

Las uniones entre tablas permiten obtener información descriptiva de cada operación, incluyendo el nombre del cliente, su ciudad, el producto y la categoría correspondiente.

Cómo ejecutar los scripts en SQL Server
Requisitos previos
Una instancia de Microsoft SQL Server en funcionamiento.
SQL Server Management Studio (SSMS) u otra herramienta compatible con SQL Server.
Permisos para crear bases de datos y tablas.
Los archivos .sql descargados desde este repositorio.
Paso 1. Clonar el repositorio

Desde una terminal, ejecutar:

bash
git clone https://github.com/Jedata1/Entregables_Coder.git
cd Entregables_Coder


También es posible descargar el repositorio como archivo ZIP desde GitHub.

Paso 2. Abrir SQL Server Management Studio
Conectarse a la instancia de SQL Server.
Abrir una nueva consulta.
Seleccionar la base de datos correspondiente o trabajar inicialmente sobre una base de administración, según las instrucciones del script.
Abrir el archivo SQLQuery3.sql.
Paso 3. Crear y cargar la base de datos

Ejecutar SQLQuery3.sql para crear la base de datos, definir las tablas e insertar los datos de ejemplo.

Importante: antes de ejecutarlo, verificar que USE Ventas_Tech_DB; aparezca antes de las instrucciones DROP TABLE y CREATE TABLE. En la versión actual, esa selección se encuentra después de la definición de las tablas, por lo que parte del script podría ejecutarse en una base de datos distinta de la esperada.

También se debe comprobar si la base de datos ya existe. No ejecutar repetidamente instrucciones de creación o eliminación sin revisar sus efectos, especialmente si se trabaja con información real.

Paso 4. Ejecutar las consultas de negocio

Una vez creada y cargada la base de datos:

Abrir m4_consultas_negocio.sql.
Verificar que la instrucción USE Ventas_Tech_DB; esté presente.
Ejecutar las consultas individualmente o por bloques.
Revisar los resultados en la pestaña de resultados de SSMS.
Paso 5. Ejecutar las consultas JOIN

Abrir m5_consultas_joins.sql y ejecutar las consultas de integración de datos.

Validar que las claves de relación existan y que los resultados incluyan la información esperada de clientes, productos y categorías.

Paso 6. Abrir los archivos de Power BI

Para revisar los entregables de visualización:

Instalar y abrir Power BI Desktop.
Abrir los archivos .pbix incluidos en el repositorio.
Si el informe solicita credenciales o una conexión, configurar el origen de datos correspondiente.
Actualizar los datos cuando sea necesario y verificar que las consultas y visualizaciones se ejecuten correctamente.

La disponibilidad de datos y las conexiones dependerán de la configuración guardada en cada archivo.

Resultados y hallazgos de negocio

El conjunto de consultas está orientado a responder preguntas relevantes para un equipo comercial:

¿Cuánto se factura por mes y cuál es el ticket promedio?
¿Qué productos generan mayor facturación?
¿Qué productos venden más unidades, independientemente de sus ingresos?
¿Qué clientes realizan compras recurrentes?
¿Qué meses se ubican por encima o por debajo del promedio de facturación?

En los datos de ejemplo incluidos en el script SQL se registran diez operaciones correspondientes a marzo de 2024.

El análisis de esos registros permite observar diferencias entre volumen de ventas y facturación: un producto puede vender pocas unidades y generar ingresos elevados, mientras otro puede registrar más unidades vendidas y aportar una facturación menor.

Estos resultados constituyen una base para evaluar precios, disponibilidad, venta cruzada y estrategias de fidelización. No deben interpretarse como resultados de una operación comercial real sin validar previamente la naturaleza y representatividad de los datos.

Buenas prácticas y consideraciones
Verificar la base de datos seleccionada antes de ejecutar operaciones de creación o eliminación.
Mantener claves primarias y foráneas para preservar la integridad referencial.
Comprobar que las consultas no dupliquen importes como consecuencia de relaciones uno a muchos.
Diferenciar unidades vendidas, registros de venta y pedidos únicos.
Utilizar fechas completas en los análisis temporales para evitar mezclar el mismo mes de distintos años.
Validar los indicadores de SQL antes de trasladarlos a Power BI.
No publicar credenciales, contraseñas ni datos personales reales en el repositorio.
Próximas mejoras

Como posibles extensiones del proyecto se proponen:

Incorporar indicadores de rentabilidad y margen, además de facturación.
Ampliar el análisis temporal con comparaciones interanuales y variaciones porcentuales.
Analizar ventas por categoría, ciudad y segmento de clientes.
Estandarizar el proceso de carga y transformación de datos.
Documentar el modelo de datos y las reglas de negocio.
Automatizar controles de calidad y validación de resultados.
Autoría y repositorio

Repositorio: Jedata1/Entregables_Coder

Proyecto de práctica y desarrollo de competencias en SQL Server, análisis de datos comerciales y visualización con Power BI.

La documentación describe los archivos y las consultas disponibles en el repositorio. Las conclusiones de negocio y las funcionalidades adicionales deberán validarse con los datos y las conexiones de cada entorno.