# Actividad 7. Conciliacion


Ejecute sql/04-registro-cambios.sql en el laboratorio. El folio y los responsables son de ejemplo, no una aprobacion real de produccion

Resultado:

    CREATE SCHEMA
    REVOKE
    CREATE TABLE
    COMMENT
    INSERT 0 1
    ALTER TABLE
    COMMENT
        folio     |   aprobado_por    |        ventana_inicio         |          ventana_fin          | dentro_de_ventana 
    --------------+-------------------+-------------------------------+-------------------------------+-------------------
     CAM-2026-014 | Comite de cambios | 2026-11-27 05:15:05.625978+00 | 2026-11-27 06:20:05.625978+00 | t
    (1 row)
    
     num |         momento         | usuario  |                        sentencia                        
    -----+-------------------------+----------+---------------------------------------------------------
      47 | 2026-11-27 05:20:05.600 | postgres | CREATE SCHEMA gobierno;
      48 | 2026-11-27 05:20:05.606 | postgres | REVOKE ALL ON SCHEMA gobierno FROM PUBLIC;
      49 | 2026-11-27 05:20:05.607 | postgres | CREATE TABLE gobierno.solicitudes_cambio (\r
      57 | 2026-11-27 05:20:05.627 | postgres | ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20);
    (4 rows)

    Fecha UTC	Usuario	Cambio	Folio	Resultado
    2026-11-27 05:20:05.627	postgres	Agregar canal_alta	CAM-2026-014	Dentro de la ventana del ejemplo
    2026-11-09 01:21:40.548	postgres	GRANT UPDATE a app_ventas	No encontrado	Preparacion del LAB-01; sin solicitud de ejemplo disponible
    2026-11-09 01:23:19.513	app_ventas	Intento de desactivar disparador	No encontrado	Intento rechazado; revisar evidencia del LAB-01
    2026-11-09 01:23:19.803	postgres	Desactivar disparador	No encontrado	Prueba del LAB-01; hallazgo de control

Los tres eventos anteriores estan en E5-anterior-postgresql-2026-11-09_012135.log lineas 38, 201 y 207. La linea 201 registra un intento rechazado; la 207 es la accion del administrador. Desactivar el disparador es importante porque permite cambios sin guardar su antes y despues. No encontrar un folio no demuestra por si solo que un cambio fuera indebido; aqui son pruebas de laboratorio

La vista dba.bitacora muestra el log actual, por eso tambien revise el anterior. Si log_statement estaba en none, algunas sentencias no quedaron guardadas y no se pueden revisar. Otra persona de auditoria deberia revisar los cambios del DBA
