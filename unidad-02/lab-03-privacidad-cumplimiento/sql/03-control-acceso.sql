-- LAB-03 Actividad 4

RESET ROLE;

-- reutilizar el rol si ya existe
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles WHERE rolname = 'analista'
    ) THEN
        CREATE ROLE analista NOLOGIN;
    END IF;
END $$;

CREATE OR REPLACE VIEW v_analitica_clientes AS
SELECT
    ciudad,
    CASE
        WHEN edad < 18 THEN 'Menor de 18'
        WHEN edad BETWEEN 18 AND 29 THEN '18-29'
        WHEN edad BETWEEN 30 AND 44 THEN '30-44'
        WHEN edad BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60 o más'
    END AS rango_edad
FROM clientes;

GRANT USAGE ON SCHEMA public TO analista;

GRANT SELECT
ON v_analitica_clientes
TO analista;

REVOKE SELECT ON clientes FROM analista;

-- verificar permisos
SELECT
    grantee,
    table_schema,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE grantee = 'analista';

-- consultar como analista
SET ROLE analista;

SELECT *
FROM v_analitica_clientes;

RESET ROLE;


SET ROLE analista;

SELECT *
FROM public.clientes;


RESET ROLE;

-- LAB-03 Actividad 6
-- 12.1 acceso
RESET ROLE;

SELECT
    id,
    nombre,
    correo,
    telefono,
    rfc,
    edad,
    ciudad,
    codigo_postal,
    fecha_alta
FROM clientes
WHERE correo = 'ana.lopez@example.test';

-- LAB-03 Actividad 7
-- 13 rectificacion
RESET ROLE;

UPDATE clientes
SET correo = 'nuevo-correo@example.com'
WHERE id = 1
  AND correo = 'ana.lopez@example.test'
RETURNING id, nombre, correo;

SELECT
    id,
    nombre,
    correo
FROM clientes
WHERE id = 1;

-- revisar la copia de soporte despues de la rectificacion
SELECT
    id,
    nombre,
    correo
FROM clientes_soporte
WHERE id = 1;
