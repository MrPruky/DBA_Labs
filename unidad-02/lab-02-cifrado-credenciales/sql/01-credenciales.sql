-- LAB-02 Actividad 1

-- preparacion
RESET ROLE;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

SELECT extname
FROM pg_extension
WHERE extname = 'pgcrypto';

-- 7.1
CREATE TABLE IF NOT EXISTS usuarios_insegura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL
);

INSERT INTO usuarios_insegura (usuario, password)
SELECT 'juan', 'Password123'
WHERE NOT EXISTS (
    SELECT 1 FROM usuarios_insegura WHERE usuario = 'juan'
);

SELECT * FROM usuarios_insegura;

-- 7.3
SELECT crypt('Password123', gen_salt('bf'));

SELECT crypt('Password123', gen_salt('bf'));

-- 7.4
CREATE TABLE IF NOT EXISTS usuarios_segura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL
);

INSERT INTO usuarios_segura (usuario, password_hash)
VALUES ('juan', crypt('Password123', gen_salt('bf')))
ON CONFLICT (usuario) DO NOTHING;

SELECT * FROM usuarios_segura;

-- 7.5 correcta
SELECT usuario,
       password_hash = crypt('Password123', password_hash)
           AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';

-- 7.5 incorrecta
SELECT usuario,
       password_hash = crypt('OtraPassword', password_hash)
           AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';

-- comparar hashes
SELECT
    crypt('Password123', gen_salt('bf')) <>
    crypt('Password123', gen_salt('bf'))
    AS hashes_distintos;
