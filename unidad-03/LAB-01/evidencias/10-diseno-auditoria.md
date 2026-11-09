# Actividades 10 y 11. Diseño y disparador

Estudiante: Osuna Rangel Diego Sebastian


Datos:

    Campo	Tipo	Qué responde	Puede ser nulo
    id_evento	BIGSERIAL	Cuál es el identificador del evento	No, clave primaria
    momento	TIMESTAMPTZ	Cuándo ocurrió	No, se requiere ordenar y comparar eventos
    usuario_sesion	TEXT	Quién abrió la sesión	No, es el usuario autenticado
    usuario_efectivo	TEXT	Con qué permisos se ejecutó	No, identifica el contexto efectivo
    aplicacion	TEXT	Qué nombre declaró el cliente	El esquema lo permite; si no se declara suele quedar vacío
    ip_cliente	INET	Desde qué dirección entró	Sí, una sesión por socket no tiene IP
    operacion	TEXT	Qué tipo de cambio fue	No, distingue altas, cambios y bajas
    id_cliente	BIGINT	A qué cliente afectó	El esquema lo permite; el disparador lo toma de la clave del cliente
    valores_antes	JSONB	Qué había antes	Sí, en un INSERT no existía la fila
    valores_despues	JSONB	Qué quedó después	Sí, en un DELETE ya no queda fila

TIMESTAMPTZ ayuda a comparar la hora aunque se trabaje en distintas zonas. En JSONB queda la fila completa para poder ver lo anterior y lo nuevo, aunque despues cambien las columnas. Esas copias tambien tienen RFC, asi que necesitan proteccion

Comando:

    SELECT tgname, tgenabled, tgrelid::regclass FROM pg_trigger WHERE NOT tgisinternal;

Resultado:

    tgname	tgenabled	tgrelid
    trg_auditoria_clientes	O	clientes

El esquema, tabla, funcion y disparador aparecen en la bitacora porque mod tambien registra DDL:

Resultado:

    114	2026-11-09 01:23:16.102 UTC [285] user=postgres db=comercial app=psql client=[local] LOG:  statement: CREATE SCHEMA auditoria;
    116	2026-11-09 01:23:16.108 UTC [285] user=postgres db=comercial app=psql client=[local] LOG:  statement: CREATE TABLE auditoria.cambios_clientes (
    131	2026-11-09 01:23:16.432 UTC [292] user=postgres db=comercial app=psql client=[local] LOG:  statement: CREATE OR REPLACE FUNCTION auditoria.registrar_cambio_cliente()
    155	2026-11-09 01:23:16.442 UTC [292] user=postgres db=comercial app=psql client=[local] LOG:  statement: CREATE TRIGGER trg_auditoria_clientes

Quite EXECUTE a PUBLIC para que no quede abierto a todos. El disparador ya creado sigue usando la funcion. Creo que, sin SECURITY DEFINER, ventas podria intentar cambiar clientes, pero fallaria al guardar la auditoria porque no tiene permiso en ese esquema
