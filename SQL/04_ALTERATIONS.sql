/*1. Nuevo cliente: Inserta un nuevo cliente en la tabla CLIENTES (inventa los datos,
asígnale una licencia nueva y una ciudad existente en el sistema).*/

INSERT INTO CLIENTES(ID_CLIENTE, NOMBRE_CLIENTE, EMAIL_CLIENTE, TELEFONO_CLIENTE, CIUDAD_CLIENTE, FECHA_REGISTRO_CLIENTE, LICENCIA_CONDUCIR_CLIENTE) VALUES
(3, 'Santiago Quiroga', 'santiquiroga@gmail.com', '2644597922', 'San Juan', '2025-09-23', 'LIC-003')
/*2. Actualizar salario: Actualiza el salario a 200000.00 para todos los empleados cuyo*/
UPDATE EMPLEADOS SET SALARIO_EMPLEADO = 200000.00
WHERE CARGO_EMPLEADO = 'vendedor' AND FECHA_INGRESO_EMPLEADO < '2021-01-1';
/*3. Borrar vehículo: Elimina un vehículo específico de la tabla VEHICULOS (asegúrate
de que no tenga alquileres, reservas ni mantenimientos asociados para evitar error
de integridad referencial).*/
DELETE FROM VEHICULOS
WHERE ID_VEHICULO = 4;
/*IMPORTANTE: Realizar primero el INSERT DE datos antes de realizar
la consulta del DELETE*/

/*4. Cambio de sucursal: Actualiza el id_sucursal de un vehículo específico porque fue
trasladado a otra sucursal.*/
UPDATE VEHICULOS SET ID_SUCURSAL = 3
WHERE ID_VEHICULO LIKE '1';
