/*1. Crea un procedimiento almacenado llamado SP_REGISTRAR_ALQUILER que
reciba como parámetros de entrada:
● p_id_cliente (ID del cliente)
● p_id_vehiculo (ID del vehículo)
● p_id_empleado (ID del empleado)
● p_fecha_inicio (fecha de inicio del alquiler)
● p_fecha_fin (fecha de fin del alquiler)
El procedimiento debe:
a. Verificar si el vehículo está disponible (estado = TRUE). Si no lo está, lanzar
un mensaje de error.
b. Calcular el total multiplicando los días de alquiler por el precio_dia del
vehículo.
c. Insertar el nuevo registro en la tabla ALQUILERES con estado 'activo'.
d. Mostrar un mensaje de éxito: "Alquiler registrado correctamente".*/  

DELIMITER $$

CREATE PROCEDURE SP_REGISTRAR_ALQUILER(
    IN p_id_cliente INT,
    IN p_id_vehiculo INT,
    IN p_id_empleado INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    DECLARE v_disponible TINYINT;
    DECLARE v_precio_dia DECIMAL(9,2);
    DECLARE v_dias INT;
    DECLARE v_total DECIMAL(9,2);
    
    SELECT ESTADO_VEHICULO, PRECIO_DIA 
    INTO v_disponible, v_precio_dia
    FROM VEHICULOS
    WHERE ID_VEHICULO = p_id_vehiculo;

    IF v_disponible = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El vehículo seleccionado no está disponible.';
    END IF;

    SET v_dias = DATEDIFF(p_fecha_fin, p_fecha_inicio);
    
    IF v_dias <= 0 THEN
        SET v_dias = 1;
    END IF;
    
    SET v_total = v_dias * v_precio_dia;


    INSERT INTO ALQUILERES (
        ID_CLIENTE, 
        ID_VEHICULO, 
        ID_EMPLEADO, 
        FECHA_INICIO, 
        FECHA_FIN, 
        TOTAL, 
        ID_SUCURSAL_RETIRO, 
        ID_SUCURSAL_DEVOLUCION, 
        ESTADO_ALQUILER
    ) 
    VALUES (
        p_id_cliente, 
        p_id_vehiculo, 
        p_id_empleado, 
        p_fecha_inicio, 
        p_fecha_fin, 
        v_total, 
        1, 
        1, 
        'activo'
    );

/*2. Crea un procedimiento almacenado llamado SP_CALCULAR_MULTA que reciba
como parámetros de entrada:
● p_id_alquiler (ID del alquiler)
● p_motivo (motivo de la multa)
● p_monto (monto de la multa)
El procedimiento debe:
a. Verificar que el alquiler exista. Si no existe, lanzar un mensaje de error.
b. Insertar la multa en la tabla MULTAS con pagada = FALSE y la fecha actual.
c. Mostrar un mensaje de éxito: "Multa registrada correctamente".*/
DELIMITER $$

CREATE PROCEDURE SP_CALCULAR_MULTA(
    IN p_id_alquiler INT,
    IN p_motivo VARCHAR(255),
    IN p_monto DECIMAL(9,2)
)
BEGIN


    IF NOT EXISTS (SELECT 1 FROM ALQUILERES WHERE ID_ALQUILER = p_id_alquiler) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El alquiler especificado no existe.';
    END IF;
    INSERT INTO MULTAS (
        ID_ALQUILER, 
        MOTIVO, 
        MONTO, 
        FECHA_MULTA, 
        PAGADA
    ) 
    VALUES (
        p_id_alquiler, 
        p_motivo, 
        p_monto, 
        CURRENT_DATE(), 
        FALSE
    );

    SELECT 'Multa registrada correctamente' AS Mensaje;

END$$

DELIMITER ;