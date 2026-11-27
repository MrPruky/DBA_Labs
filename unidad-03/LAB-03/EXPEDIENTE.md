# Expediente de auditoria interna - Base comercial

Estudiante: Osuna Rangel Diego Sebastian

## 1. Alcance

Use PostgreSQL 16.15 en Docker con la base comercial y tome como referencia MongoDB 7 Community del LAB-02. Revise registros de PostgreSQL del 9 y 27 de noviembre de 2026 en UTC. Los responsables y las aprobaciones son ejemplos de la practica, no decisiones reales de una empresa

## 2. Configuracion de auditoria

PostgreSQL tiene el colector activado y log_statement en mod. Esa consulta esta en evidencias/E1-configuracion-registro.txt. El disparador de clientes aparece activo en E3-disparadores.txt y algunos eventos estan en E4-muestra-auditoria.txt

MongoDB Community usa perfilador y bitacora, no auditoria nativa. Las copias estan en evidencias/E6-mongodb. Sus horas fueron modificadas para una representacion; no demuestran el horario real. La auditoria nativa de Enterprise/Atlas esta documentada en la guia, no fue probada

## 3. Bitacora interpretada

1. Acceso fallido: 2026-11-09 01:21:39.275 UTC, usuario declarado app_ventas, cliente 127.0.0.1. La autenticacion fallo; no demuestra quien era la persona. E5-anterior-postgresql-2026-11-09_012135.log, linea 22

2. Cambio de telefono de Maria: 2026-11-09 01:21:43.126 UTC, app_ventas, aplicacion app-ventas-web, cliente 127.0.0.1. La sentencia UPDATE quedo en la linea 71 del mismo archivo. La linea muestra el telefono nuevo, no el anterior

3. RFC de Maria: el evento 1 de auditoria registra el UPDATE de app_ventas desde app-ventas-web y 127.0.0.1 a las 2026-11-09 01:23:17.357893 UTC. E4-muestra-auditoria.txt muestra metadatos y LAB-01/evidencias/11-incidente-auditado.md contiene los valores de la prueba. El incidente anterior sin registro no puede atribuirse con esa evidencia

4. Cambio de estructura: 2026-11-27 05:20:05.627 UTC, postgres, psql, conexion local. Se agrego canal_alta; E5-bitacora-postgresql.log linea 57 y 06-conciliacion.md lo relacionan con el folio de ejemplo CAM-2026-014

## 4. Datos y responsables

Los responsables estan en evidencias/02-responsables.md, el catalogo en 04-catalogo.md y el diccionario en 03-diccionario.md y diccionario-clientes.csv. Los datos que salieron mal estan en 01-calidad.md

## 5. Conservacion

Los siete tipos de registro, plazos propuestos y responsables estan en evidencias/05-conservacion.md. Los plazos legales deben confirmarse; el hash no reemplaza una copia protegida

## 6. Politicas

Las seis propuestas estan en politicas/POL-01-acceso.md a POL-06-cambios-produccion.md. Cada una indica su evidencia o reconoce lo que todavia no existe. Las politicas de respaldo y restauracion dejan el procedimiento tecnico para la Unidad V

## 7. Conciliacion

La solicitud y el cambio de ejemplo quedaron dentro de la ventana, como se ve en evidencias/06-conciliacion.md. No encontre folios para los cambios del LAB-01. Fueron pruebas, pero habria que revisarlos antes de decir si estaban autorizados. Tambien quedo registrado que postgres apago el disparador

## 8. Hallazgos

    ID	Hallazgo	Fuente	Severidad	Impacto	Recomendacion	Decision
    H1	Correo duplicado y datos invalidos	01-calidad.md	Media	Errores de contacto o facturacion	Confirmar con las areas y corregir autorizado	Gerencia Comercial y Facturacion
    H2	Disparador desactivable por administrador	06-conciliacion.md y E5 anterior linea 207	Alta	Cambios sin registro antes y despues	Revision independiente y copia externa	Auditoria y Seguridad
    H3	Cambios sin folio encontrado	06-conciliacion.md	Media	No se puede confirmar aprobacion	Revisar si eran preparacion o requerian solicitud	Comite de cambios
    H4	MongoDB Community sin auditoria nativa	E6-mongodb/09-comparacion.md	Alta	No atribuye todos los cambios de permisos	Evaluar controles y auditoria nativa	Seguridad y direccion
    H5	Horas de MongoDB modificadas para representacion	07-evidencias-tecnicas.md	Alta	No prueban el momento real	Repetir y guardar exportaciones reales	Auditoria
    H6	Cronologia del LAB-01 difiere de los logs	LAB-01/evidencias/15-cronologia.md y E5 anterior	Media	Fechas distintas para eventos	Usar el log exportado y corregir la cronologia tras revision	Auditoria

## 9. Limitaciones y riesgos

Vi que el administrador pudo apagar el disparador. E1 solo muestra la configuracion en el momento de la consulta y, con log_statement en mod, las lecturas no quedan registradas como sentencias comunes. MongoDB Community no tiene auditoria nativa y las copias de permisos no dicen por si solas quien hizo un cambio. Seguridad y Auditoria deben revisar estos riesgos y Direccion decidir si los acepta

Las horas de E6 se cambiaron para una representacion. Tambien vi que la cronologia del LAB-01 dice 8 de noviembre y la bitacora y los eventos de auditoria dicen 9 de noviembre UTC. Hay que revisar esa diferencia antes de usar las fechas como evidencia

## 10. Indice

- evidencias/01-calidad.md a 07-evidencias-tecnicas.md
- evidencias/diccionario-clientes.csv
- evidencias/E1-configuracion-registro.txt, E2-privilegios.txt, E3-disparadores.txt y E4-muestra-auditoria.txt
- evidencias/E5-bitacora-postgresql.log y E5-anterior-postgresql-2026-11-09_012135.log
- evidencias/E5-bitacora-postgresql.sha256
- evidencias/E6-mongodb: perfilador, bitacora, hashes y comparacion
- sql/01-verificaciones-calidad.sql a 04-registro-cambios.sql
- politicas/POL-01-acceso.md a POL-06-cambios-produccion.md

Hashes de las copias E5:

    5808a015e5da2e72e514bb95ab51884b16fa773aafd948dbdd35e32608c0c40e  E5-anterior-postgresql-2026-11-09_012135.log
    0f28eee3c60e18148a9151c57c6e69a058b226f0dfaabd4915e1182f844bd358  E5-bitacora-postgresql.log

## Reflexion

1. Sin responsables y reglas, no se sabe quien debe corregir los datos o aprobar accesos
2. postgres es dueño tecnico de las tablas; el area de negocio decide sobre el uso del dato
3. Una politica necesita registros para comprobar que se cumplio
4. El catalogo y los permisos cambian; conviene revisarlos con cada cambio y periodicamente
5. La desactivacion del disparador tiene impacto alto porque puede dejar cambios sin auditoria de valores
6. Explicar los limites evita asegurar algo que no se puede demostrar
