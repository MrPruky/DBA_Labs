CREATE SCHEMA gobierno;
REVOKE ALL ON SCHEMA gobierno FROM PUBLIC;
CREATE TABLE gobierno.solicitudes_cambio (
 folio TEXT PRIMARY KEY, descripcion TEXT NOT NULL, solicitado_por TEXT NOT NULL, aprobado_por TEXT,
 ambiente TEXT NOT NULL CHECK (ambiente IN ('desarrollo','pruebas','produccion')),
 fecha_aprobacion TIMESTAMPTZ, ventana_inicio TIMESTAMPTZ, ventana_fin TIMESTAMPTZ
);
COMMENT ON TABLE gobierno.solicitudes_cambio IS 'Registro de solicitudes de cambio de ejemplo en comercial. Propietario propuesto: Comite de cambios. Custodio: DBA.';
-- Solicitud de ejemplo: el entorno es un laboratorio, no una aprobacion real.
INSERT INTO gobierno.solicitudes_cambio VALUES
('CAM-2026-014','Agregar columna canal_alta a clientes','Gerencia Comercial','Comite de cambios','produccion',now()-interval '1 day',now()-interval '5 minutes',now()+interval '1 hour');
ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20);
COMMENT ON COLUMN clientes.canal_alta IS 'Canal por el que se registro el cliente. Cambio de ejemplo CAM-2026-014.';
SELECT folio,aprobado_por,ventana_inicio,ventana_fin,ventana_inicio<=now() AND now()<=ventana_fin AS dentro_de_ventana FROM gobierno.solicitudes_cambio;
SELECT num,substr(linea,1,23) AS momento,substring(linea from 'user=([^ ]*)') AS usuario,
 substring(linea from 'statement: (.*)$') AS sentencia FROM dba.bitacora
WHERE linea ~ 'statement: (CREATE|ALTER|DROP|GRANT|REVOKE)' ORDER BY num;
