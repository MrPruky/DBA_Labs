# Actividad 8. Errores y operaciones rechazadas

Estudiante: Osuna Rangel Diego Sebastian


Prueba:

    psql por TCP, soporte_ana@127.0.0.1/comercial, app=psql
    DELETE FROM clientes WHERE id = 5

Resultado:

    ERROR:  permission denied for table clientes

Comando:

    DROP ROLE soporte_ana;

Resultado:

    ERROR:  role "soporte_ana" cannot be dropped because some objects depend on it
    DETAIL:  privileges for table clientes

Resultado:

    linea
    2026-11-09 01:21:44.114 UTC [225] user=soporte_ana db=comercial app=psql client=127.0.0.1 ERROR:  permission denied for table clientes
    2026-11-09 01:21:44.114 UTC [225] user=soporte_ana db=comercial app=psql client=127.0.0.1 STATEMENT:  DELETE FROM clientes WHERE id = 5
    2026-11-09 01:21:44.440 UTC [232] user=postgres db=comercial app=psql client=[local] ERROR:  role "soporte_ana" cannot be dropped because some objects depend on it
    2026-11-09 01:21:44.440 UTC [232] user=postgres db=comercial app=psql client=[local] DETAIL:  privileges for table clientes
    2026-11-09 01:21:44.440 UTC [232] user=postgres db=comercial app=psql client=[local] STATEMENT:  DROP ROLE soporte_ana;

Soporte si pudo entrar, pero no tenia permiso para borrar, asi que no se elimino el cliente. Aun asi quedo el intento en la bitacora. En la actividad 5 el problema fue al entrar; aqui fue un permiso despues de entrar. El rol no se pudo borrar porque todavia tenia permisos. Antes habria que revisar y quitar o cambiar esos permisos
