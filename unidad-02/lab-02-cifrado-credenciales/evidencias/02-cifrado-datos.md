# 02 Cifrado de informacion sensible

OSUNA RANGEL DIEGO SEBASTIAN

## Objetivo

Cifrar un RFC de prueba y recuperarlo con la clave correcta, tambien probar que pasa con una clave incorrecta

## Comando o procedimiento

Primero cree la tabla e inserte los datos ficticios de la practica

    CREATE TABLE clientes_protegidos (
        id BIGSERIAL PRIMARY KEY,
        nombre VARCHAR(120) NOT NULL,
        rfc_cifrado BYTEA NOT NULL
    );

    INSERT INTO clientes_protegidos (nombre, rfc_cifrado)
    VALUES (
        'Ana López',
        pgp_sym_encrypt('LOPA900101ABC', 'CLAVE-DE-PRUEBA')
    );

    SELECT * FROM clientes_protegidos;

Despues use la misma clave para recuperar el dato

    SELECT
        id,
        nombre,
        pgp_sym_decrypt(
            rfc_cifrado,
            'CLAVE-DE-PRUEBA'
        ) AS rfc
    FROM clientes_protegidos;

Por ultimo probe con otra clave

    SELECT pgp_sym_decrypt(
        rfc_cifrado,
        'OTRA-CLAVE-DE-PRUEBA'
    )
    FROM clientes_protegidos;

## Resultado obtenido

Salio el registro de Ana Lopez con id 1, el RFC aparecio como datos binarios y no se podia leer directamente

Con la clave correcta pude ver el RFC de prueba, LOPA900101ABC, en la captura se ve recortado porque la columna es pequena

Con la clave incorrecta aparecio

    ERROR: Wrong key or corrupt data
    SQL state: 39000

## Analisis

### Que diferencia existe entre crypt y pgp_sym_encrypt

crypt sirve para generar y comprobar un hash de contrasena, pgp_sym_encrypt cifra un dato que despues se puede recuperar con la clave

### Cual permite recuperar el dato original

El cifrado con pgp_sym_encrypt, para recuperarlo se usa pgp_sym_decrypt con la clave correcta

### Que ocurre con una clave incorrecta

No se recupera el RFC y aparece el error Wrong key or corrupt data

### Que problema representa colocar la clave directamente en una consulta

La clave puede quedar en el archivo SQL, en el historial de consultas o en una captura, si alguien la obtiene y tambien tiene los datos cifrados podria descifrarlos

## Conclusion

El RFC se guardo cifrado y pude recuperarlo usando la misma clave, con otra clave aparecio un error, esto es diferente del hash porque aqui si necesito recuperar el dato original, las claves de este ejemplo son ficticias y no se deben usar como claves reales
