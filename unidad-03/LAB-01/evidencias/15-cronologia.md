# Actividades 16 y 17. Exportacion y cronologia

Estudiante: Osuna Rangel Diego Sebastian


Exporte la bitacora y quite la contraseña temporal, la cambie por <REDACTED> antes de sacarla del contenedor. El archivo tiene 253 lineas y revise que no quedaran contraseñas de prueba ni resumenes SCRAM

Comando:
Get-FileHash evidencias/bitacora-lab01.log -Algorithm SHA256

El SHA-256 esta en bitacora-lab01.sha256, sirve para saber si cambio el archivo pero no evita que lo modifiquen. Guardaria el log y el hash fuera del servidor y con acceso limitado. Para la practica propongo guardarlos 90 dias, aunque alguna regla o investigacion podria pedir mas tiempo

## Cronologia

Las horas estan en UTC y las lineas son del archivo que exporte

Datos:

    #	Fecha UTC	Usuario	Cliente	Tipo	Que ocurrio	Exitoso	Fuente
    1	2026-11-08 01:21:38.033	Proceso principal	Local	Configuracion	Se activo el registro DDL.	Si	Linea 11
    2	2026-11-08 01:21:39.275	app_ventas	127.0.0.1	Acceso	Se rechazo una contraseña incorrecta.	No	Linea 22
    3	2026-11-08 01:21:39.569	usuario_inexistente	127.0.0.1	Acceso	Se rechazo un rol que no existe.	No	Linea 25
    4	2026-11-08 01:21:39.91	app_ventas	127.0.0.1	Acceso	Entro la cuenta de ventas.	Si	Linea 30
    5	2026-11-08 01:21:40.541	postgres	[local]	Privilegio	Se quitaron los permisos de soporte.	Si	Linea 37
    6	2026-11-08 01:21:40.549	postgres	[local]	Estructura	Se agrego la columna segmento.	Si	Linea 39
    7	2026-11-08 01:21:43.126	app_ventas	127.0.0.1	Datos	Ventas cambio el telefono del cliente 3.	Si	Linea 71
    8	2026-11-08 01:21:44.114	soporte_ana	127.0.0.1	Error	Soporte intento borrar un cliente.	No	Linea 83
    9	2026-11-08 01:23:17.357893	app_ventas	127.0.0.1	UPDATE	Ventas cambio el RFC del cliente 3.	Si	id_evento 1
    10	2026-11-08 01:23:18.5902	postgres	Local	INSERT	Se inserto un cliente de prueba.	Si	id_evento 2
    11	2026-11-08 01:23:18.610049	postgres	Local	DELETE	Se borro el cliente de prueba.	Si	id_evento 3
    12	2026-11-08 01:23:19.804	postgres	[local]	Datos	El administrador cambio el RFC sin disparador.	Si	Linea 208
    13	2026-11-08 01:23:19.805	postgres	[local]	Estructura	Se volvio a activar el disparador, al final salio O.	Si	Linea 209

## Preguntas

1. RFC, actividad 3: No hay evidencia en la bitacora del autor, hora, aplicacion o IP. En la actividad 7 con ddl: No hay evidencia de la sentencia de RFC ni de quien la ejecuto; una conexion de ventas no demuestra por si sola que hizo el UPDATE. Actividad 12: app_ventas, app-ventas-web, 127.0.0.1, 2026-11-08T01:23:17.357893+00:00 (evento 1). Actividad 14: la linea 208 muestra a postgres, desde psql por socket local, ejecutando el cambio; la sesion confirmo el UPDATE 1.
2. Telefono: app_ventas desde app-ventas-web y 127.0.0.1; la hora y la sentencia estan en la linea 71. Ese registro no contiene el telefono anterior
3. Intentos fallidos: app_ventas y usuario_inexistente, ambos desde 127.0.0.1, despues de habilitar los registros y antes del cambio auditado. Para lo que paso antes de activarlos no hay evidencia que permita confirmar o descartar intentos
4. RFC anterior: en las actividades 3 y 7 no hay evidencia historica del valor justo antes del cambio. El evento 1 conserva GAMA780912XYZ antes y GAMA780912ZZZ despues. En la actividad 14 no hay evidencia directa del valor anterior en ese evento porque el disparador estaba deshabilitado. GAMA780912ZZZ era el ultimo valor auditado; la linea 208 conserva el valor nuevo, no el anterior
5. Huecos: no asigne hora ni autor al incidente sin registro ni al cambio de RFC bajo ddl. La hora de una conexion no sustituye la hora de una sentencia que no se registro
