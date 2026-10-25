/*Crea un Trigger llamado TR_AUDITAR_ALQUILER que se dispare después de
insertar un nuevo registro en la tabla ALQUILERES e inserte un registro en
AUDITORIA_ALQUILERES con los datos correspondientes. Para ello, antes debes
crear la tabla con los siguientes atributos:
● id_auditoria (autoincremental, PK)
● id_alquiler (del alquiler insertado)
● id_cliente (del alquiler insertado)
● id_vehiculo (del alquiler insertado)
● fecha_registro (fecha y hora actual del sistema)
● accion (texto que diga "NUEVO ALQUILER")*/
CREATE TABLE AUDITORIA_ALQUILERES(
    ID_AUDITORIA INT PRIMARY KEY AUTO_INCREMENT,
    ID_ALQUILER INT NOT NULL,
    ID_CLIENTE INT NOT NULL,
    ID_VEHICULO INT NOT NULL,
    FECHA_REGISTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ACCION VARCHAR(50) NOT NULL
);

DELIMITER $$

CREATE TRIGGER TR_AUDITAR_ALQUILER
AFTER INSERT ON ALQUILERES
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_ALQUILERES (
        ID_ALQUILER,
        ID_CLIENTE,
        ID_VEHICULO,
        ACCION
    )
    VALUES (
        NEW.ID_ALQUILER,
        NEW.ID_CLIENTE,
        NEW.ID_VEHICULO,
        'NUEVO ALQUILER'
    );
END$$

DELIMITER ;

/*2. Crea un Trigger llamado TR_ACTUALIZAR_ESTADO_VEHICULO que se dispare
después de insertar un nuevo registro en ALQUILERES. Si el alquiler se inserta con
estado 'activo', el trigger debe actualizar el campo estado del vehículo alquilado a
FALSE (no disponible).*/
DELIMITER $$

CREATE TRIGGER TR_ACTUALIZAR_ESTADO_VEHICULO
AFTER INSERT ON ALQUILERES
FOR EACH ROW
BEGIN
    IF LOWER(NEW.ESTADO_ALQUILER) = 'activo' THEN
        UPDATE VEHICULOS
        SET ESTADO_VEHICULO = 0
        WHERE ID_VEHICULO = NEW.ID_VEHICULO;
    END IF;
END$$

DELIMITER ;