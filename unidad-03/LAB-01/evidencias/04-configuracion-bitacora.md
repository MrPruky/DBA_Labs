# Actividad 4. Configurar la bitacora

Estudiante: Osuna Rangel Diego Sebastian


Comando:

    ALTER SYSTEM SET log_connections = on;
    ALTER SYSTEM SET log_disconnections = on;
    ALTER SYSTEM SET log_line_prefix = '%m [%p] user=%u db=%d app=%a client=%h ';
    ALTER SYSTEM SET log_statement = 'ddl';
    SELECT pg_reload_conf();

Comando:

    ALTER SYSTEM
    ALTER SYSTEM
    ALTER SYSTEM
    ALTER SYSTEM
    pg_reload_conf
    t

La revision la hice en otra conexion despues de la recarga:

Comando:

    SELECT name, setting, source, sourcefile
    FROM pg_settings
    WHERE name IN ('log_connections', 'log_line_prefix', 'log_statement');

Resultado:

    name	setting	source	sourcefile
    log_connections	on	configuration file	/var/lib/postgresql/data/postgresql.auto.conf
    log_line_prefix	%m [%p] user=%u db=%d app=%a client=%h	configuration file	/var/lib/postgresql/data/postgresql.auto.conf
    log_statement	ddl	configuration file	/var/lib/postgresql/data/postgresql.auto.conf

Lineas de la bitacora exportada:

Resultado:

    8 | 2026-11-09 01:21:38.033 UTC [1] LOG:  parameter "log_connections" changed to "on"
    9 | 2026-11-09 01:21:38.033 UTC [1] LOG:  parameter "log_disconnections" changed to "on"
    10 | 2026-11-09 01:21:38.033 UTC [1] user= db= app= client= LOG:  parameter "log_line_prefix" changed to "%m [%p] user=%u db=%d app=%a client=%h "
    11 | 2026-11-09 01:21:38.033 UTC [1] user= db= app= client= LOG:  parameter "log_statement" changed to "ddl"

Al recargar, el proceso principal anoto los valores nuevos. Esa linea no dice por si sola quien pidio el cambio. Si el registro de sentencias ya estaba activo, el ALTER SYSTEM para apagarlo puede aparecer antes de la recarga. Despues dejarian de registrarse esas sentencias. Conviene usar ALTER SYSTEM para cambiar postgresql.auto.conf y no editarlo a mano
