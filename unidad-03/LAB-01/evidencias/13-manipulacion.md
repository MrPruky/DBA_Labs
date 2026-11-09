# Actividad 14. Manipulacion de auditoria

Estudiante: Osuna Rangel Diego Sebastian


Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=app-ventas-web
    DELETE FROM auditoria.cambios_clientes

Resultado:

    ERROR:  permission denied for schema auditoria
    LINE 1: DELETE FROM auditoria.cambios_clientes
                        ^

Prueba:

    psql por TCP, app_ventas@127.0.0.1/comercial, app=app-ventas-web
    ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes

Resultado:

    ERROR:  must be owner of table clientes

Comando:

    BEGIN;
    ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes;
    UPDATE clientes SET rfc = 'GAMA780912GHI' WHERE id = 3;
    ALTER TABLE clientes ENABLE TRIGGER trg_auditoria_clientes;
    SELECT count(*) FROM auditoria.cambios_clientes;
    COMMIT;

Comando:

    BEGIN
    ALTER TABLE
    UPDATE 1
    ALTER TABLE
    count
    3

Comando:

    COMMIT

Resultado:

    linea
    2026-11-09 01:23:19.513 UTC [364] user=app_ventas db=comercial app=app-ventas-web client=127.0.0.1 LOG:  statement: ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes
    2026-11-09 01:23:19.803 UTC [371] user=postgres db=comercial app=psql client=[local] LOG:  statement: ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes;
    2026-11-09 01:23:19.804 UTC [371] user=postgres db=comercial app=psql client=[local] LOG:  statement: UPDATE clientes SET rfc = 'GAMA780912GHI' WHERE id = 3;
    2026-11-09 01:23:19.805 UTC [371] user=postgres db=comercial app=psql client=[local] LOG:  statement: ALTER TABLE clientes ENABLE TRIGGER trg_auditoria_clientes;

Ventas no pudo borrar la auditoria ni apagar el disparador. El administrador si lo apago, cambio el RFC y lo volvio a prender. La auditoria siguio con tres registros. En la bitacora si quedaron las ordenes DISABLE, UPDATE y ENABLE, asi se puede notar que hubo un cambio fuera de la auditoria. La orden de ventas tambien aparecio en el log, aunque fue rechazada. Para cuidar las pruebas otra persona deberia revisar y guardar una copia de la bitacora
