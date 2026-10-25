# Requerimientos del Sistema y Modelo de Datos: Sistema de Alquiler de Vehículos

## 1. Descripción del Modelo de Datos
El presente modelo representa la gestión operativa de una empresa dedicada al **alquiler de vehículos** a clientes. 

Permite administrar el ciclo de vida completo de un alquiler: desde la reserva y asignación del vehículo en una sucursal de retiro, pasando por las inspecciones físicas de entrega y devolución (`CHECK_ALQUILER`), hasta el cálculo final de cobros y el registro de multas por eventualidades o demoras.

---

## 2. Relaciones del Modelo e Interacciones Inversas
El diseño relacional se compone de las siguientes entidades e interacciones principales:

* **SUCURSALES - ALQUILERES (Relación Doble 1:N):** 
  * *Directa:* Una sucursal actúa como punto de retiro para muchos alquileres.
  * *Inversa:* Un alquiler pertenece exactamente a una sucursal de retiro (`id_sucursal_retiro`) y a una sucursal de devolución (`id_sucursal_devolucion`).
* **CATEGORIAS - VEHICULOS (1:N):** 
  * *Directa:* Una categoría agrupa a muchos vehículos.
  * *Inversa:* Cada vehículo pertenece a una sola categoría que define su tarifa base por día.
* **VEHICULOS - ALQUILERES (1:N):** 
  * *Directa:* Un vehículo puede registrar muchos alquileres a lo largo de su vida útil.
  * *Inversa:* Un alquiler individual asigna exactamente un vehículo.
* **CLIENTES - ALQUILERES (1:N):** 
  * *Directa:* Un cliente puede realizar múltiples alquileres.
  * *Inversa:* Cada alquiler está asociado a un único cliente titular.
* **ALQUILERES - CHECK_ALQUILER (1:N):** 
  * *Directa:* Un alquiler posee dos registros de inspección (diferenciados por el campo `tipo`: `'salida'` y `'entrada'`).
  * *Inversa:* Cada chequeo refiere de forma unívoca a un alquiler en particular.
* **ALQUILERES - MULTAS (1:N):** 
  * *Directa:* Un alquiler puede generar cero, una o más multas.
  * *Inversa:* Cada multa está vinculada obligatoriamente a un alquiler específico.
* **SUCURSALES - EMPLEADOS (1:N):** 
  * *Directa:* Una sucursal emplea a múltiples trabajadores.
  * *Inversa:* Un empleado está asignado formalmente a una única sucursal.

---

## 3. Requerimientos Funcionales (RF)

### RF-01: Gestión de Alquileres
* El sistema debe permitir el registro de un nuevo alquiler mediante el procedimiento almacenado `SP_REGISTRAR_ALQUILER`.
* El sistema debe calcular automáticamente el costo total del alquiler multiplicando la cantidad de días (`DATEDIFF`) por la tarifa diaria del vehículo.
* El sistema debe verificar la disponibilidad del vehículo (`disponible = TRUE`) antes de confirmar la transacción.

### RF-02: Gestión de Vehículos y Estados
* El sistema debe actualizar de forma automática el estado del vehículo a no disponible (`disponible = FALSE`) inmediatamente después de registrarse un alquiler activo (a través del trigger `TR_ACTUALIZAR_ESTADO_VEHICULO`).

### RF-03: Registro de Multas
* El sistema debe permitir registrar multas asociadas a un alquiler mediante el procedimiento almacenado `SP_CALCULAR_MULTA`.
* Debe validar previamente que el ID del alquiler exista en el sistema; de lo contrario, debe retornar un mensaje de error.
* Toda nueva multa se registrará con la fecha actual del sistema (`CURRENT_DATE()`) y estado de pago en `FALSE`.

### RF-04: Auditoría de Tarifas
* El sistema debe auditar cualquier actualización en el precio por día de un vehículo (mediante el trigger `TR_AUDITORIA_PRECIO_VEHICULO`), guardando en la tabla `AUDITORIA_PRECIOS` el valor anterior, el valor nuevo, la fecha y el usuario que realizó el cambio.

### RF-05: Inspección de Vehículos
* El sistema debe registrar las inspecciones de vehículos en una única tabla unificada (`CHECK_ALQUILER`), utilizando la columna `tipo` para discriminar las revisiones de `'salida'` y `'entrada'`.

---

## 4. Requerimientos No Funcionales (RNF)

### RNF-01: Integridad Referencial y Seguridad de Datos
* La eliminación de registros padre debe estar restringida (`RESTRICT`) en entidades clave como `CATEGORIAS`, impidiendo el borrado de una categoría si posee vehículos vinculados.

### RNF-02: Control de Accesos por Roles (DCL)
* El sistema debe implementar políticas de seguridad restringiendo permisos según el rol del usuario:
  * **`vendedor_user`:** Acceso restringido de solo lectura (`SELECT`) sobre tablas de consulta operativa (`VEHICULOS`, `CATEGORIAS`, `SUCURSALES`), sin permisos de modificación ni eliminación (`DELETE`).
  * **`adm_user`:** Acceso administrativo completo (`ALL PRIVILEGES`) para la gestión integral de la base de datos.

### RNF-03: Normalización y Eficiencia
* El modelo de datos debe cumplir con la **Tercera Forma Normal (3FN)** para evitar redundancia de datos y garantizar la consistencia en nombres, atributos y tarifas.

### RNF-04: Robustez y Manejo de Excepciones
* Las operaciones en procedimientos almacenados deben cancelar su ejecución y devolver códigos de error descriptivos mediante `SIGNAL SQLSTATE '45000'` ante la violación de reglas de negocio o datos inexistentes.