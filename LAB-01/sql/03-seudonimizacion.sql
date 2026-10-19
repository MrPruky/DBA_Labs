--actividad 3 seudonimizacion
CREATE SCHEMA pii;

CREATE SCHEMA analitica;

--Crear la tabla de correspondencia
CREATE TABLE pii.mapa_cliente (
    token UUID PRIMARY KEY,
    cliente_id BIGINT UNIQUE
        REFERENCES public.clientes(id)
);

--GENERAR LOS TOKKENS
--activar habilidad necesaria
CREATE EXTENSION IF NOT EXISTS pgcrypto;

--genera un tokken para cada clientes
INSERT INTO pii.mapa_cliente
(token, cliente_id)
SELECT
    gen_random_uuid(),
    id
FROM clientes;

--verificar
SELECT *
FROM pii.mapa_cliente;

--CREAR EL CONJUNTO DE DATOS PARA ANALITICA
CREATE TABLE analitica.clientes AS
SELECT
    m.token AS cliente_token,
    c.edad,
    c.ciudad,
    c.codigo_postal,
    c.fecha_alta
FROM pii.mapa_cliente m
JOIN clientes c
    ON c.id = m.cliente_id;

--verificar
SELECT *
FROM analitica.clientes;

--. Actividad 4 — Separación de funciones

--crear el rol
CREATE ROLE analista NOLOGIN;
--Conceder acceso al conjunto de datos analítico:

GRANT USAGE
ON SCHEMA analitica
TO analista;

GRANT SELECT
ON analitica.clientes
TO analista;

--El acceso al conjunto analítico debe estar permitido:
SELECT *
FROM analitica.clientes;

--El acceso al mapa de correspondencia debe estar restringido:
SELECT *
FROM pii.mapa_cliente;

--También debe estar restringido el acceso directo a los datos originales:

SELECT *
FROM public.clientes;