# Actividad 3. Incidente sin registro

Estudiante: Osuna Rangel Diego Sebastian


Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=app-ventas-web
    UPDATE clientes SET rfc = 'GAMA780912XXX' WHERE id = 3

Comando:

    UPDATE 1

Comando:

    SELECT linea FROM dba.bitacora
    WHERE linea ILIKE '%update%' OR linea LIKE '%app_ventas%';

Resultado:

    linea

La prueba hizo el cambio con app_ventas, pero la bitacora salio vacia. Solo con ese archivo no puedo demostrar quien cambio el RFC, cuando o desde donde. Tampoco puedo descartar a soporte_ana usando ese evento. Ventas tenia permiso de actualizar; para saber lo ocurrido hacia falta registrar la conexion y el cambio antes del incidente
