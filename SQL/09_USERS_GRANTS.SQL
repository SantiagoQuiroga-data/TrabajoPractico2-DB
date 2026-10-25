/*Crea un usuario llamado 'vendedor_user'@'localhost' con una contraseña segura.*/
CREATE USER 'vendedor_user'@'localhost'
IDENTIFIED BY 'clave_segura';
/*2. Otorga permisos de Solo Lectura (SELECT) sobre las tablas VEHICULOS,
CATEGORIAS y SUCURSALES al usuario vendedor_user (no debe poder
modificarlas).*/
GRANT SELECT ON VEHICULOS TO 'vendedor_user'@'localhost';
GRANT SELECT ON CATEGORIAS TO 'vendedor_user'@'localhost';
GRANT SELECT ON SUCURSALES TO 'vendedor_user'@'localhost';
/*3. Otorga permisos de Lectura y Escritura (SELECT, INSERT, UPDATE, DELETE)
sobre la tabla ALQUILERES y PAGOS al mismo usuario (porque él registra los
alquileres y cobros).*/

GRANT SELECT, INSERT, UPDATE, DELETE ON ALQUILERES TO 'vendedor_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON PAGOS TO 'vendedor_user'@'localhost';


/*Crea un usuario 'admin_user'@'localhost' y otórgale TODOS LOS PRIVILEGIOS
sobre la base de datos completa.*/
CREATE USER 'adm_user'@'localhost'
IDENTIFIED BY 'clave_segura';

GRANT ALL PRIVILEGES ON *.* TO 'adm_user'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;


/*5. Escribe la sentencia para revocar el permiso de DELETE sobre la tabla
ALQUILERES al usuario vendedor_user (por si borra un alquiler por error).*/
REVOKE DELETE ON ALQUILERES FROM 'vendedor_user'@'localhost';