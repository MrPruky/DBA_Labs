# Actividad 5. Accesos correctos y fallidos

Estudiante: Osuna Rangel Diego Sebastian


Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=psql
    SELECT 1

Resultado:

    psql: error: connection to server at "127.0.0.1", port 5432 failed: FATAL:  password authentication failed for user "app_ventas"

Prueba:

    psql por TCP, usuario_inexistente@127.0.0.1/comercial, app=psql
    SELECT 1

Resultado:

    psql: error: connection to server at "127.0.0.1", port 5432 failed: FATAL:  password authentication failed for user "usuario_inexistente"

Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=app-ventas-web
    SELECT count(*) FROM clientes

Resultado:

    count
    5

En la linea 22: 2026-11-09 01:21:39.275 UTC es la hora UTC, 119 el PID, app_ventas el usuario declarado, comercial la base, [unknown] la aplicacion, 127.0.0.1 el cliente y FATAL indica que la conexion fallo. La linea de detalle del mismo PID indica la regla aplicada de pg_hba.conf

Resultado:

    22 | 2026-11-09 01:21:39.275 UTC [119] user=app_ventas db=comercial app=[unknown] client=127.0.0.1 FATAL:  password authentication failed for user "app_ventas"
    25 | 2026-11-09 01:21:39.569 UTC [126] user=usuario_inexistente db=comercial app=[unknown] client=127.0.0.1 FATAL:  password authentication failed for user "usuario_inexistente"
    26 | 2026-11-09 01:21:39.569 UTC [126] user=usuario_inexistente db=comercial app=[unknown] client=127.0.0.1 DETAIL:  Role "usuario_inexistente" does not exist.
    30 | 2026-11-09 01:21:39.910 UTC [133] user=app_ventas db=comercial app=[unknown] client=127.0.0.1 LOG:  connection authorized: user=app_ventas database=comercial application_name=app-ventas-web

El intento fallido muestra que alguien escribio app_ventas desde esa IP; no demuestra que fuera la aplicacion ni una persona en especifico. En el servidor aparece que el otro usuario no existe, pero al cliente le sale un error parecido. En el fallo no termino la conexion; en la conexion correcta ya aparece el nombre de la aplicacion que mando el cliente

Varios intentos fallidos seguidos desde una misma IP o para un usuario serian algo que revisaria. Para contarlos:

Comando:

    SELECT split_part(split_part(linea, ' user=', 2), ' db=', 1) AS usuario,
           count(*) AS intentos
    FROM dba.bitacora
    WHERE linea LIKE '% FATAL:  password authentication failed for user %'
    GROUP BY 1 ORDER BY 2 DESC;
