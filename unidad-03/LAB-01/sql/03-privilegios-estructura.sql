-- Actividad 6.

REVOKE UPDATE ON clientes FROM soporte_ana;
GRANT UPDATE ON clientes TO app_ventas;
ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20);

-- Prueba opcional dentro de la actividad: ejecutar este bloque en psql con CLAVE_TEMPORAL definida.

-- No copiar al repositorio la línea de bitácora sin redactar la contraseña.

\getenv clave_temporal CLAVE_TEMPORAL
CREATE ROLE rol_temporal LOGIN PASSWORD :'clave_temporal';
DROP ROLE rol_temporal;
