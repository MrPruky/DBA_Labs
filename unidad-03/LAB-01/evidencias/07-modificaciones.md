# Actividad 7. ddl frente a mod

Estudiante: Osuna Rangel Diego Sebastian


Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=app-ventas-web
    UPDATE clientes SET rfc = 'GAMA780912XYZ' WHERE id = 3

Comando:

    UPDATE 1

Comando:

    SELECT linea FROM dba.bitacora WHERE linea LIKE '%user=app_ventas%' ORDER BY num DESC LIMIT 3;

Resultado:

    linea
    2026-11-09 01:21:41.534 UTC [169] user=app_ventas db=comercial app=app-ventas-web client=127.0.0.1 LOG:  disconnection: session time: 0:00:00.012 user=app_ventas database=comercial host=127.0.0.1 port=55922
    2026-11-09 01:21:41.529 UTC [169] user=app_ventas db=comercial app=[unknown] client=127.0.0.1 LOG:  connection authorized: user=app_ventas database=comercial application_name=app-ventas-web
    2026-11-09 01:21:41.529 UTC [169] user=app_ventas db=comercial app=[unknown] client=127.0.0.1 LOG:  connection authenticated: identity="app_ventas" method=scram-sha-256 (/var/lib/postgresql/data/pg_hba.conf:119)

Con ddl aparece la sesion de ventas, no el UPDATE del RFC. Cambie a mod, verifique el valor despues de recargar y probe:

Comando:

    ALTER SYSTEM SET log_statement = 'mod';
    SELECT pg_reload_conf();

Comando:

    ALTER SYSTEM
    pg_reload_conf
    t

Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=app-ventas-web
    UPDATE clientes SET telefono = '6679990000' WHERE id = 3
    SELECT nombre, rfc FROM clientes WHERE id = 3

Comando:

    UPDATE 1
    nombre	rfc
    María García	GAMA780912XYZ

Resultado:

    64 | 2026-11-09 01:21:42.493 UTC [1] user= db= app= client= LOG:  parameter "log_statement" changed to "mod"
    71 | 2026-11-09 01:21:43.126 UTC [204] user=app_ventas db=comercial app=app-ventas-web client=127.0.0.1 LOG:  statement: UPDATE clientes SET telefono = '6679990000' WHERE id = 3

Con mod aparecio el cambio del telefono, pero no el SELECT. Con all tambien se guardaria la lectura, aunque el archivo creceria y podria contener mas datos privados. En ese UPDATE solo aparece el telefono nuevo, asi que con esa linea no puedo saber cual tenia antes
