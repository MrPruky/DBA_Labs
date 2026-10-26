-- LAB-03 Actividad 2

RESET ROLE;

-- 8.1
CREATE TABLE IF NOT EXISTS clientes_soporte (
    id BIGINT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20)
);

INSERT INTO clientes_soporte (
    id,
    nombre,
    correo,
    telefono
)
SELECT
    id,
    nombre,
    correo,
    telefono
FROM clientes
ON CONFLICT (id) DO NOTHING;

SELECT *
FROM clientes_soporte;
