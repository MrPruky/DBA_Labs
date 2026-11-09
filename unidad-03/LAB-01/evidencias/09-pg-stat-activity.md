# Actividad 9. Sesiones activas

Estudiante: Osuna Rangel Diego Sebastian


En una conexion TCP, soporte_ana ejecuto SELECT pg_sleep(90) con application_name=reporte-mensual. El PID observado fue 252.

Comando:

    SELECT pid, usename, application_name, client_addr, backend_start, state, left(query, 30) AS query
    FROM pg_stat_activity
    WHERE backend_type = 'client backend';

Resultado:

    pid |   usename   |     application_name     | client_addr |         backend_start         | state  |             query
    -----+-------------+--------------------------+-------------+-------------------------------+--------+--------------------------------
     260 | postgres    | psql                     |             | 2026-11-09 01:21:45.344951+00 | active | SELECT pid, usename, applicati
      48 | postgres    | pgAdmin 4 - DB:comercial | 172.21.0.3  | 2026-11-09 01:21:36.089875+00 | idle   | /*pga4dash*/                  +
         |             |                          |             |                               |        | SELECT 'session_s
     252 | soporte_ana | reporte-mensual          | 127.0.0.1   | 2026-11-09 01:21:45.047985+00 | active | SELECT pg_sleep(90)
    (3 rows)

Cuando termino, repeti la consulta y reporte-mensual ya no salio. Busque su PID en la bitacora:

Comando:

    SELECT linea FROM dba.bitacora WHERE linea LIKE '%[252]%' ORDER BY num;

Resultado:

    linea
    2026-11-09 01:21:45.048 UTC [252] user=[unknown] db=[unknown] app=[unknown] client=127.0.0.1 LOG:  connection received: host=127.0.0.1 port=55944
    2026-11-09 01:21:45.056 UTC [252] user=soporte_ana db=comercial app=[unknown] client=127.0.0.1 LOG:  connection authenticated: identity="soporte_ana" method=scram-sha-256 (/var/lib/postgresql/data/pg_hba.conf:119)
    2026-11-09 01:21:45.056 UTC [252] user=soporte_ana db=comercial app=[unknown] client=127.0.0.1 LOG:  connection authorized: user=soporte_ana database=comercial application_name=reporte-mensual
    2026-11-09 01:23:15.088 UTC [252] user=soporte_ana db=comercial app=reporte-mensual client=127.0.0.1 LOG:  disconnection: session time: 0:01:30.040 user=soporte_ana database=comercial host=127.0.0.1 port=55944

pg_stat_activity muestra las sesiones que estan activas en ese momento. La bitacora conserva la conexion y desconexion despues de que termina. El administrador no tenia IP porque entro por socket local, no por red
