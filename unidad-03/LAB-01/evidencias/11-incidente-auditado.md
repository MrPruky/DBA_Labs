# Actividad 12. Incidente auditado

Estudiante: Osuna Rangel Diego Sebastian


Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=app-ventas-web
    UPDATE clientes SET rfc = 'GAMA780912ZZZ' WHERE id = 3

Comando:

    UPDATE 1

Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=psql
    SELECT * FROM auditoria.cambios_clientes

Resultado:

    ERROR:  permission denied for schema auditoria
    LINE 1: SELECT * FROM auditoria.cambios_clientes
                          ^

Resultado:

    \x
    SELECT id_evento, momento, usuario_sesion, usuario_efectivo, aplicacion, ip_cliente, operacion, id_cliente
    FROM auditoria.cambios_clientes ORDER BY id_evento;
    \x

Resultado:

    Expanded display is on.
    -[ RECORD 1 ]----+------------------------------
    id_evento        | 1
    momento          | 2026-11-09 01:23:17.357893+00
    usuario_sesion   | app_ventas
    usuario_efectivo | postgres
    aplicacion       | app-ventas-web
    ip_cliente       | 127.0.0.1
    operacion        | UPDATE
    id_cliente       | 3

Resultado:

    Expanded display is off.

Comando:

    SELECT a.id_evento, a.momento, a.usuario_sesion, a.ip_cliente,
           d.key                     AS campo,
           a.valores_antes ->> d.key AS antes,
           d.value #>> '{}'          AS despues
    FROM auditoria.cambios_clientes a
    CROSS JOIN LATERAL jsonb_each(a.valores_despues) d
    WHERE a.operacion = 'UPDATE'
      AND a.valores_antes -> d.key IS DISTINCT FROM d.value
    ORDER BY a.id_evento;

Resultado:

    id_evento	momento	usuario_sesion	ip_cliente	campo	antes	despues
    1	2026-11-09 01:23:17.357893+00	app_ventas	127.0.0.1	rfc	GAMA780912XYZ	GAMA780912ZZZ

Ventas pudo actualizar, aunque no pudo consultar la auditoria. La funcion uso los permisos de su dueño (postgres), mientras session_user guardo app_ventas. El RFC cambio de GAMA780912XYZ a GAMA780912ZZZ. Esta consulta habria regresado el valor anterior en ese momento; no la ejecute en esta actividad:

Comando:

    UPDATE clientes SET rfc = 'GAMA780912XYZ' WHERE id = 3;

El cliente puede escribir otro application_name, asi que es mas facil cambiarlo. La IP ayuda a saber desde donde llego la conexion, pero tambien puede ser compartida y no identifica por si sola a una persona
