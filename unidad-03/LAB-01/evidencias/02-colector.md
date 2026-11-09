# Actividad 2. Colector y vista

Estudiante: Osuna Rangel Diego Sebastian


Comando:

    ALTER SYSTEM SET logging_collector = on;
    SELECT name, setting, pending_restart FROM pg_settings WHERE name = 'logging_collector';

Comando:

    ALTER SYSTEM
    name	setting	pending_restart
    logging_collector	off	f

Despues de SELECT pg_reload_conf();, el cambio quedo pendiente:

Comando:

    SELECT name, setting, pending_restart FROM pg_settings WHERE name = 'logging_collector';

Resultado:

    name	setting	pending_restart
    logging_collector	off	t

Reinicie con docker restart dba-u3-pg y abri una sesion nueva:

Comando:

    SELECT name, setting, source FROM pg_settings WHERE name = 'logging_collector';
    SELECT pg_current_logfile();

Resultado:

    name	setting	source
    logging_collector	on	configuration file

Resultado:

    pg_current_logfile
    log/postgresql-2026-11-09_012135.log

Cree el esquema dba, quite el acceso a PUBLIC y cree la vista con los comandos de sql/01-colector-y-vista.sql. La vista mostro las lineas de arranque:

Resultado:

    -- últimas 10 líneas
    SELECT num, linea FROM dba.bitacora ORDER BY num DESC LIMIT 10;

Resultado:

    num	linea
    6	2026-11-09 01:21:35.615 UTC [1] LOG:  database system is ready to accept connections
    5	2026-11-09 01:21:35.602 UTC [30] LOG:  database system was shut down at 2026-11-09 01:21:34 UTC
    4	2026-11-09 01:21:35.589 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
    3	2026-11-09 01:21:35.583 UTC [1] LOG:  listening on IPv6 address "::", port 5432
    2	2026-11-09 01:21:35.583 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
    1	2026-11-09 01:21:35.582 UTC [1] LOG:  starting PostgreSQL 16.15 (Debian 16.15-1.pgdg13+2) on x86_64-pc-linux-gnu, compiled by gcc (Debian 14.2.0-19) 14.2.0, 64-bit

El colector necesita reinicio porque arranca junto con el servidor. log_statement si cambia con una recarga. Con la vista puedo buscar en el log desde SQL, pero tambien podria ver datos privados. Por eso la deje para el administrador. La vista muestra el archivo actual; si se crea otro, tambien hay que guardar el anterior
