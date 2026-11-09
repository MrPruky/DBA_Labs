# Informe LAB-01 Unidad 3

Estudiante: Osuna Rangel Diego Sebastian

## Como empece

Use PostgreSQL 16.15 en Docker y la base comercial. Al principio el colector y el registro de conexiones estaban apagados, y log_statement estaba en none

Hice un cambio de RFC pero no aparecio en la bitacora, entonces con ese archivo no se podia saber quien lo hizo

## Lo que hice y encontre

Active logging_collector y reinicie el servidor. Despues active el registro de conexiones y desconexiones y configure el prefijo para guardar la hora, usuario, base, aplicacion e IP. El prefijo quedo en %m [%p] user=%u db=%d app=%a client=%h. Tambien puse log_statement en ddl y despues en mod, recargando y revisando cada cambio. log_min_error_statement quedo en error y la hora estaba en UTC

- En la linea 11 quedo el cambio a ddl
- En la linea 22 quedo un intento fallido con app_ventas. Tambien hubo una conexion correcta con SCRAM, pero escribir un usuario en un intento no demuestra quien era
- Se registraron el REVOKE de soporte y el ALTER TABLE que agrego segmento
- Con mod se registro el UPDATE del telefono en la linea 71. Con ddl no se registro el UPDATE del RFC
- Soporte no pudo borrar un cliente y el administrador no pudo borrar un rol que todavia tenia permisos. Los intentos quedaron en el registro

## Auditoria

La tabla auditoria.cambios_clientes guarda la hora, usuario, aplicacion, IP, operacion y los datos de la fila antes y despues. El disparador funciona con INSERT, UPDATE y DELETE

SECURITY DEFINER usa los permisos del dueño de la funcion para guardar la auditoria y session_user conserva la cuenta que inicio sesion. En el evento 1, app_ventas cambio el RFC de GAMA780912XYZ a GAMA780912ZZZ y el usuario efectivo fue postgres. Ventas no pudo leer ni borrar la auditoria

## Lo que no quedo registrado

La lectura de soporte no se guardo con mod. Cuando cambie cinco filas quedo una linea en la bitacora y cinco filas en la auditoria

El administrador pudo apagar y volver a prender el disparador. Eso quedo en la bitacora, pero no se guardo el antes y despues de ese cambio. Por eso otra persona podria guardar y revisar una copia de los registros

La bitacora puede tener contraseñas u otros datos y tambien se puede perder o quedar expuesta. Exporte una copia con <REDACTED> en lugar de la contraseña temporal y saque su SHA-256

## Lo que entendi

1. Si activo la auditoria despues, no puedo recuperar lo que no se registro antes
2. El colector ayuda a guardar y revisar los archivos del servidor. Para conservarlos hace falta una copia afuera
3. log_statement decide que se guarda y el prefijo ayuda a ver la hora, usuario, direccion y sesion
4. La sentencia muestra lo que se hizo y la auditoria tambien puede guardar lo que habia antes
5. pg_stat_activity muestra las sesiones del momento y el log conserva los eventos registrados despues de que terminan
6. Como el administrador tiene mucho acceso, otra persona deberia revisar los cambios y guardar una copia de las bitacoras

## Conclusion

Al final pude ver quien cambio el RFC que si quedo auditado y cual era el valor anterior. Los cambios de antes de activar el registro no se pudieron comprobar igual, tampoco el valor anterior del cambio que se hizo con el disparador apagado

Eso lo deje en la [cronologia](evidencias/15-cronologia.md). No hice la parte C porque es opcional
