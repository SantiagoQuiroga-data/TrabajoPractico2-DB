# Respuestas sobre el Modelo de Datos de Alquiler de Vehículos

---

### 1. Relación entre Alquileres y Sucursales

Un alquiler involucra dos momentos físicos o geográficos distintos en el ciclo de vida del servicio: el punto de inicio (donde el cliente retira el auto) y el punto de finalización (donde lo entrega). Ambas acciones pueden ocurrir en la misma sucursal o en sucursales diferentes. Por ende, la tabla `ALQUILERES` necesita dos vías de conexión independientes con la tabla `SUCURSALES`.

* **Tipo de relación:** Representa dos relaciones independientes de **Uno a Muchos (1:N)** entre `SUCURSALES` y `ALQUILERES`. 
* **Justificación:** Una sucursal puede ser la sucursal de retiro de muchos alquileres y también la sucursal de devolución de muchos alquileres.

---

### 2. Eliminación de una Categoría asociada a Vehículos

La base de datos debe evaluar la regla de **Integridad Referencial** configurada en la clave foránea para evitar dejar registros "huérfanos" (vehículos haciendo referencia a una categoría inexistente).

* **Comportamiento recomendado:** Lo ideal sería definir la restricción según las reglas del negocio:
  * **`RESTRICT` / `NO ACTION` (Opción más viable):** Impide la eliminación de la categoría mientras existan vehículos asociados a ella, protegiendo la integridad de la flota y los datos históricos.
  * **`SET NULL`:** Si se elimina la categoría, se actualiza automáticamente a `NULL` la clave foránea de los vehículos afectados.

* **Conclusión:** La opción `RESTRICT` es la más aconsejable para evitar incoherencias en el inventario.

---

### 3. Normalización de Categorías y Tercera Forma Normal (3FN)

El diseño separa el autor o la categoría en una tabla independiente para aplicar la **Tercera Forma Normal (3FN)** y evitar la redundancia de datos.

* **Ventajas:**
  * **Consistencia de datos:** Evita errores tipográficos al repetir información en múltiples registros.
  * **Ahorro de espacio:** Almacena el texto descriptivo una sola vez y lo vincula mediante claves numéricas (IDs).
  * **Atributos centralizados:** Facilita la actualización de la información centralizada en un único punto.

---

### 4. Relación entre Sucursales y Empleados

* **Tipo de relación:** Es una relación de **Uno a Muchos (1:N)** desde `SUCURSALES` hacia `EMPLEADOS`.
* **Justificación:** Una sucursal física emplea a muchos empleados, pero en un modelo administrativo estándar, cada empleado pertenece o está asignado formalmente a una sola sucursal a la vez (lo que se refleja mediante el campo `ID_SUCURSAL` como clave foránea dentro de la tabla `EMPLEADOS`).

---

### 5. Consolidación de Revisiones (Check-in / Check-out)

Las revisiones de *salida* (check-out) y *entrada* (check-in) se unifican en una sola estructura debido a que comparten exactamente la misma naturaleza y los mismos atributos de datos:
* Fecha y hora
* Estado del tanque de combustible
* Kilometraje
* Detalles o daños del vehículo
* Empleado a cargo
* `ID_ALQUILER`

* **Ventajas:** Evita la duplicación de tablas y esquemas, simplifica la escritura de consultas SQL y hace que el modelo sea más escalable a futuro.