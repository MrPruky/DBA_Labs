-- LAB-02 Actividad 2

RESET ROLE;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- 8.1
CREATE TABLE IF NOT EXISTS clientes_protegidos (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    rfc_cifrado BYTEA NOT NULL
);

INSERT INTO clientes_protegidos (
    nombre,
    rfc_cifrado
)
SELECT
    'Ana López',
    pgp_sym_encrypt('LOPA900101ABC', 'CLAVE-DE-PRUEBA')
WHERE NOT EXISTS (
    SELECT 1 FROM clientes_protegidos WHERE nombre = 'Ana López'
);

SELECT * FROM clientes_protegidos;

-- 8.2
SELECT
    id,
    nombre,
    pgp_sym_decrypt(
        rfc_cifrado,
        'CLAVE-DE-PRUEBA'
    ) AS rfc
FROM clientes_protegidos;

-- clave incorrecta
-- ejecutar solamente este SELECT por separado
/*
SELECT pgp_sym_decrypt(
    rfc_cifrado,
    'OTRA-CLAVE-DE-PRUEBA'
)
FROM clientes_protegidos;
*/
