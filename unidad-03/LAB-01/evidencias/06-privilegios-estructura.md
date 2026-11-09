# Actividad 6. Privilegios y estructura

Estudiante: Osuna Rangel Diego Sebastian


Comando:

    REVOKE UPDATE ON clientes FROM soporte_ana;
    GRANT UPDATE ON clientes TO app_ventas;
    ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20);

Comando:

    REVOKE
    GRANT
    ALTER TABLE

Tambien cree y elimine rol_temporal para comprobar que se registra al escribir una contraseña en la sentencia. En el archivo que exporte ya quite la contraseña:

Resultado:

    37	2026-11-09 01:21:40.541 UTC [148] user=postgres db=comercial app=psql client=[local] LOG:  statement: REVOKE UPDATE ON clientes FROM soporte_ana;
    38	2026-11-09 01:21:40.548 UTC [148] user=postgres db=comercial app=psql client=[local] LOG:  statement: GRANT UPDATE ON clientes TO app_ventas;
    39	2026-11-09 01:21:40.549 UTC [148] user=postgres db=comercial app=psql client=[local] LOG:  statement: ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20);
    43	2026-11-09 01:21:40.866 UTC [155] user=postgres db=comercial app=psql client=[local] LOG:  statement: CREATE ROLE rol_temporal LOGIN PASSWORD '<REDACTED>';
    44	2026-11-09 01:21:40.888 UTC [155] user=postgres db=comercial app=psql client=[local] LOG:  statement: DROP ROLE rol_temporal;

REVOKE y GRANT cambian permisos, ALTER TABLE cambia la tabla. Los tres quedaron registrados con ddl. El REVOKE no dio error aunque soporte no tuviera ese permiso. Al borrar el rol temporal, la linea de la contraseña siguio en la bitacora. Por eso hay que cuidar quien puede leerla. Con \password no se envia la contraseña en texto normal; si aparece su resumen SCRAM, tambien hay que protegerlo
