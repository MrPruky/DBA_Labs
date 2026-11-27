# Actividad 4. Catalogo

Consulte las tablas con sql/03-inventario-tablas.sql. Resultado antes de crear gobierno.solicitudes_cambio:

    ANALYZE
      esquema  |      tabla       | propietario_tecnico | filas_estimadas | tamano |                                                        descripcion                                                         
    -----------+------------------+---------------------+-----------------+--------+----------------------------------------------------------------------------------------------------------------------------
     auditoria | cambios_clientes | postgres            |              10 | 32 kB  | 
     public    | clientes         | postgres            |               7 | 24 kB  | Clientes de Comercializadora Norte. Propietario propuesto: Gerencia Comercial. Custodio: DBA. Clasificacion: confidencial.
    (2 rows)

    ID	Conjunto	Motor y ubicacion	Propietario propuesto	Custodio	Clasificacion	Datos personales	Finalidad	Conservacion	Diccionario
    CAT-01	Clientes	PostgreSQL dba-u3-pg / comercial / public.clientes	Gerencia Comercial	DBA	Confidencial	Si	Atencion y facturacion	Mientras exista finalidad y plazo acordado	diccionario-clientes.csv
    CAT-02	Auditoria clientes	PostgreSQL dba-u3-pg / comercial / auditoria.cambios_clientes	Auditoria interna	DBA	Confidencial	Si	Revisar cambios	1 año propuesto	LAB-01 sql/04 y 05
    CAT-03	Solicitudes	PostgreSQL dba-u3-pg / comercial / gobierno.solicitudes_cambio	Comite de cambios	DBA	Interno	Puede tener nombres	Control de cambios	1 año propuesto	sql/04-registro-cambios.sql
    CAT-04	Clientes tienda	MongoDB dba-u3-lab02-mongo / comercial / clientes	Gerencia Comercial	DBA	Confidencial	Si	Tienda en linea	Mientras exista finalidad y plazo acordado	LAB-02 scripts/comandos-mongosh.js
    CAT-05	Perfilador	MongoDB dba-u3-lab02-mongo / comercial / system.profile	Seguridad y auditoria	DBA	Confidencial	Puede tener datos de consultas	Investigar operaciones	90 dias exportados propuestos	LAB-02 evidencia 03
    CAT-06	Vista bitacora	PostgreSQL dba-u3-pg / comercial / dba.bitacora	Seguridad y auditoria	DBA	Confidencial	Puede contenerlos	Consultar log actual	Ver criterio del log	LAB-01 sql/01

La auditoria y el perfilador pueden guardar datos personales. Si los datos de clientes son distintos en cada motor, las areas responsables deben acordar quien los corrige. El tamaño y las filas pueden cambiar, por eso el DBA debe actualizar el catalogo. postgres es dueño tecnico de la tabla, no del dato de negocio
