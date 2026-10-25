1. 
Un alquiler involucra dos momentos fisicos o geograficos distintos en el ciclo de vida del servicio: el punto de inicio (donde el cliente retira el auto) y el punto de finalizacion (donde lo entrega). Ambas acciones pueden ocurrir en la misma sucursal o en sucursales diferentes. Por ende, la tabla ALQUILERES necesita dos vias de conexion independientes con la tabla SUCURSALES.

Tipo de relacion: Representa dos relaciones independientes de Uno a Muchos (1:N) entre SUCURSALES y ALQUILERES. Una sucursal puede ser la sucursal de retiro de muchos alquileres y tambien la de devolucion de muchos alquileres.

2. 
Debe evaluar la regla de Integridad Referencial configurada en la clave foranea para evitar dejar registros "huerfanos" (vehiulos haciendo referencia a una categoria inexistente)
Lo idea seria usar RESTRICT o SET NULL, pero si debo elegir una seria RESTRICT ya que impide bloquear o eliminar la categoria mientas existan vehiculos. SET NULL genera que si se elimina categoria se actualiza a null la clave foranea de los vehiculos. Teniendo en cuenta eso RESTRICT es una opcion mas viable

3.
 Para aplicar la Tercera Forma Normal (3FN) y evitar redundancia de datos. Genera una consistencia de datos, ahorro de espacio y atributos centralizados

4. 
Tipo de relacion: Es una relacion de Uno a Muchos (1:N) (desde SUCURSALES hacia EMPLEADOS).
 Una sucursal fisica emplea a muchos empleados, pero en un modelo administrativo estandar, cada empleado pertenece o esta asignado formalmente a una sola sucursal a la vez (lo que se refleja mediante el campo ID_SUCURSAL como clave foranea dentro de la tabla EMPLEADOS).

5.
 Porque las revisiones de 'salida' (check-out) y 'entrada' (check-in) comparten exactamente la misma estructura de datos (mismos atributos: fecha, hora, estado del tanque, kilometraje, detalles/daños, empleado a cargo, id_alquiler).
Evita la duplicacion de estructuras, simplifica las consultas y es mas escalables a futuro
