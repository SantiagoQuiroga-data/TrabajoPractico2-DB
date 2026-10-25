

/*1)Muestra la marca, modelo y año de todos los vehículos registrados, ordenados del
más antiguo al más nuevo.*/

SELECT MARCA_VEHICULO, MODELO_VEHICULO, ANIO_AUTO
FROM VEHICULOS
ORDER BY ANIO_AUTO ASC;

/*2)Obtén el nombre, email y ciudad de todos los clientes registrados el mes anterior.*/

SELECT NOMBRE_CLIENTE, EMAIL_CLIENTE, CIUDAD_CLIENTE
FROM CLIENTES
WHERE MONTH(FECHA_REGISTRO_CLIENTE) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
AND YEAR(FECHA_REGISTRO_CLIENTE) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH);

/*3)Muestra la marca, modelo y precio por día de los vehículos que pertenecen a la
categoría con id = 2.*/

SELECT MARCA_VEHICULO, MODELO_VEHICULO, PRECIO_DIA
FROM VEHICULOS
WHERE ID_CATEGORIA = 2;

/*4. Lista todos los datos de los empleados cuyo nombre comience con la letra "L".*/
SELECT NOMBRE_EMPLEADO
FROM EMPLEADOS
WHERE NOMBRE_EMPLEADO LIKE 'L%';

/*5. Muestra el nombre y cargo de los empleados cuyo salario sea distinto a 180000.00.*/
SELECT NOMBRE_EMPLEADO, CARGO_EMPLEADO
FROM EMPLEADOS
WHERE SALARIO_EMPLEADO <> 180000.00;

/*6. Muestra la marca y modelo del vehículo junto con el nombre de su categoría.*/

SELECT v.MARCA_VEHICULO, v.MODELO_VEHICULO, c.NOMBRE_CATEGORIA
FROM VEHICULOS v
JOIN CATEGORIAS c ON c.ID_CATEGORIA = v.ID_VEHICULO; 

/*7. Realiza una consulta que muestre:
a. Fecha de inicio del alquiler (fecha_inicio)
b. Nombre del cliente (nombre)
c. Marca y modelo del vehículo (marca + modelo)
d. Nombre del empleado que atendió (nombre)*/
SELECT a.FECHA_INICIO, c.NOMBRE_CLIENTE,v.MARCA_VEHICULO, v.MODELO_VEHICULO, e.NOMBRE_EMPLEADO
FROM ALQUILERES a
JOIN CLIENTES c ON a.ID_CLIENTE = c.ID_CLIENTE
JOIN VEHICULOS v ON a.ID_VEHICULO = v.ID_VEHICULO
JOIN EMPLEADOS e ON a.ID_EMPLEADO = e.ID_EMPLEADO; 
/*8. Muestra el nombre del cliente, su ciudad y la fecha de registro.*/
SELECT NOMBRE_CLIENTE, CIUDAD_CLIENTE, FECHA_REGISTRO_CLIENTE
FROM CLIENTES

/*9. Lista la marca, modelo del vehículo junto con el nombre de la sucursal y la ciudad
donde se encuentra.*/
SELECT v.MARCA_VEHICULO, v.MODELO_VEHICULO, s.NOMBRE_SUCURSAL, s.CIUDAD
FROM VEHICULOS v
JOIN SUCURSALES s ON v.ID_SUCURSAL = s.ID_SUCURSAL;
/*10. Muestra el nombre del alquiler y el nombre de la sucursal de retiro y la de devolución
(pueden ser distintas).*/

SELECT a.ID_ALQUILER, s_retiro.NOMBRE_SUCURSAL AS SUCURSAL_RETIRO, s_devolucion.NOMBRE_SUCURSAL AS SUCURSAL_DEVOLUCION
FROM ALQUILERES a
LEFT JOIN SUCURSALES s_retiro ON a.ID_SUCURSAL_RETIRO = s_retiro.ID_SUCURSAL
LEFT JOIN SUCURSALES s_devolucion ON a.ID_SUCURSAL_DEVOLUCION = s_devolucion.ID_SUCURSAL;
/*11. ¿Cuántos vehículos hay registrados por cada categoría? Muestra el nombre de la
categoría y la cantidad.*/
SELECT c.NOMBRE_CATEGORIA, COUNT(v.ID_VEHICULO) AS CANTIDAD_VEHICULOS
FROM CATEGORIAS c
LEFT JOIN VEHICULOS v ON c.ID_CATEGORIA = v.ID_CATEGORIA
GROUP BY c.NOMBRE_CATEGORIA;
/*12. Calcula el precio promedio por día de los vehículos agrupados por categoría.*/
SELECT c.NOMBRE_CATEGORIA, AVG(PRECIO_DIA) AS PRECIO_DIA_VEHICULO
FROM CATEGORIAS c
LEFT JOIN VEHICULOS v ON v.ID_CATEGORIA = c.ID_CATEGORIA
GROUP BY NOMBRE_CATEGORIA;
/*13. Muestra el nombre del empleado y cuántos alquileres ha gestionado en total
(ordenado de mayor a menor).*/

SELECT e.NOMBRE_EMPLEADO, COUNT(a.ID_ALQUILER) AS CANTIDAD_ALQUILERES
FROM ALQUILERES a
LEFT JOIN EMPLEADOS e ON e.ID_EMPLEADO = a.ID_EMPLEADO
GROUP BY e.NOMBRE_EMPLEADO
ORDER BY CANTIDAD_ALQUILERES DESC;
/*14. Lista los clientes que tienen más de 1 alquiler registrado en el sistema.*/
SELECT c.NOMBRE_CLIENTE, COUNT(a.ID_ALQUILER) AS CANTIDAD_ALQUILERES
FROM ALQUILERES a
JOIN CLIENTES c ON c.ID_CLIENTE = a.ID_CLIENTE
GROUP BY c.NOMBRE_CLIENTE
HAVING COUNT(a.ID_ALQUILER) > 1;
/*15. Muestra el nombre de la ciudad y la cantidad de sucursales que hay en cada una.*/
SELECT CIUDAD, COUNT(NOMBRE_SUCURSAL) AS CANTIDAD_SUCURSALES
FROM SUCURSALES
GROUP BY CIUDAD;
/*16. Muestra la marca, modelo y año del vehículo más antiguo de la flota.*/
SELECT MARCA_VEHICULO, MODELO_VEHICULO, ANIO_AUTO
FROM VEHICULOS
ORDER BY ANIO_AUTO ASC
LIMIT 1;

/*17. Lista los vehículos que nunca han sido alquilados.*/
SELECT v.MODELO_VEHICULO
FROM ALQUILERES a
RIGHT JOIN VEHICULOS v ON v.ID_VEHICULO = a.ID_VEHICULO
WHERE a.ID_ALQUILER IS NULL
/*18. Muestra los alquileres cuyo estado sea 'activo' y que hayan comenzado en el mes de
octubre de 2024.*/
SELECT *
FROM ALQUILERES
WHERE ESTADO_ALQUILER = "ACTIVO" AND 
FECHA_INICIO BETWEEN '2024-10-01' AND '2024-10-31';
/*19. Muestra los 3 vehículos con el precio por día más alto.*/
SELECT PRECIO_DIA, MARCA_VEHICULO, MODELO_VEHICULO
FROM VEHICULOS
ORDER BY PRECIO_DIA DESC
LIMIT 3;
/*20. Muestra la cantidad total de multas pagadas y el monto total recaudado por multas
pagadas.*/
SELECT COUNT(PAGADA) AS CANTIDAD_PAGADA, SUM(MONTO_MULTA) AS MONTO_RECAUDADO_MULTA
FROM MULTAS;


