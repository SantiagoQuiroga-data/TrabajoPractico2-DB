/*1. Crea una vista llamada VW_ALQUILERES_DETALLE que muestre de forma
"amigable" la información de los alquileres. En lugar de mostrar los IDs numéricos,
debe mostrar:
● Fecha de inicio y fecha de fin del alquiler.
● Nombre completo del cliente.
● Marca y modelo del vehículo.
● Nombre del empleado que gestionó el alquiler.
● Nombre de la sucursal de retiro y nombre de la sucursal de devolución.
● Total del alquiler.*/

CREATE VIEW VW_ALQUILERES_DETALLE AS
SELECT a.FECHA_INICIO, a.FECHA_FIN, c.NOMBRE_CLIENTE, v.MARCA_VEHICULO, v.MODELO_VEHICULO, e.NOMBRE_EMPLEADO, s_retiro.NOMBRE_SUCURSAL AS SUCURSAL_RETIRO, s_devolucion.NOMBRE_SUCURSAL AS SUCURSAL_DEVOLUCION, TOTAL
FROM ALQUILERES a
LEFT JOIN SUCURSALES s_retiro ON a.ID_SUCURSAL_RETIRO = s_retiro.ID_SUCURSAL
LEFT JOIN SUCURSALES s_devolucion ON a.ID_SUCURSAL_DEVOLUCION = s_devolucion.ID_SUCURSAL
JOIN CLIENTES c ON a.ID_CLIENTE = c.ID_CLIENTE
JOIN VEHICULOS v ON a.ID_VEHICULO = v.ID_VEHICULO
JOIN EMPLEADOS e ON a.ID_EMPLEADO = e.ID_EMPLEADO;


/*2. Crea una vista llamada VW_VEHICULOS_POR_SUCURSAL que muestre el nombre
de la sucursal, la ciudad donde está y la cantidad total de vehículos que posee. Esto
le servirá al administrador para ver rápidamente qué sede tiene más flota.*/

CREATE VIEW VW_VEHICULOS_POR_SUCURSAL AS
SELECT s.NOMBRE_SUCURSAL, s.CIUDAD, COUNT(v.ID_VEHICULO) AS CANTIDAD_VEHICULOS
FROM SUCURSALES s
LEFT JOIN VEHICULOS v ON s.ID_SUCURSAL = v.ID_SUCURSAL
GROUP BY s.NOMBRE_SUCURSAL, s.CIUDAD;


/*3.Crea una vista llamada VW_INGRESOS_POR_CATEGORIA que muestre el nombre
de la categoría, la cantidad de alquileres finalizados y el monto total facturado por
esa categoría (solo alquileres con estado 'finalizado').*/
CREATE VIEW VW_INGRESOS_POR_CATEGORIA AS
SELECT c.NOMBRE_CATEGORIA, COUNT(a.ID_ALQUILER) AS ALQUILERES_FINALIZADOS, SUM(a.total) AS TOTAL_FACTURADO
FROM ALQUILERES a
JOIN VEHICULOS v ON v.ID_VEHICULO = a.ID_VEHICULO
JOIN CATEGORIAS c ON c.ID_CATEGORIA = v.ID_CATEGORIA
WHERE a.ESTADO_ALQUILER = 'Finalizado'
GROUP BY c.NOMBRE_CATEGORIA;

