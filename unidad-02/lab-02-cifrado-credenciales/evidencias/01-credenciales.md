# 01 Proteccion de credenciales

OSUNA RANGEL DIEGO SEBASTIAN

## Objetivo

Ver que pasa al guardar una contrasena completa y despues probar como se guarda usando un hash

## Comando o procedimiento

Use los ejemplos ficticios de la practica, primero habilite pgcrypto

    CREATE EXTENSION IF NOT EXISTS pgcrypto;
    SELECT extname FROM pg_extension WHERE extname = 'pgcrypto';

El resultado fue pgcrypto

Despues cree usuarios_insegura e inserte el usuario de prueba

    CREATE TABLE usuarios_insegura (
        id BIGSERIAL PRIMARY KEY,
        usuario VARCHAR(50) NOT NULL,
        password VARCHAR(100) NOT NULL
    );

    INSERT INTO usuarios_insegura (usuario, password)
    VALUES ('juan', 'Password123');

    SELECT * FROM usuarios_insegura;

Tambien ejecute la generacion del hash con los ejemplos de la practica

    SELECT crypt('Password123', gen_salt('bf'));
    SELECT crypt('Password123', gen_salt('bf'));

Despues cree usuarios_segura

    CREATE TABLE usuarios_segura (
        id BIGSERIAL PRIMARY KEY,
        usuario VARCHAR(50) UNIQUE NOT NULL,
        password_hash TEXT NOT NULL
    );

    INSERT INTO usuarios_segura (usuario, password_hash)
    VALUES ('juan', crypt('Password123', gen_salt('bf')));

    SELECT * FROM usuarios_segura;

Para comprobar las contrasenas use estas consultas por separado

    SELECT usuario,
           password_hash = crypt('Password123', password_hash)
               AS contraseña_correcta
    FROM usuarios_segura
    WHERE usuario = 'juan';

    SELECT usuario,
           password_hash = crypt('OtraPassword', password_hash)
               AS contraseña_correcta
    FROM usuarios_segura
    WHERE usuario = 'juan';

## Resultado obtenido

La tabla insegura mostro

    id | usuario | password
    1  | juan    | Password123

Uno de los hashes obtenidos al ejecutar crypt fue

    $2a$06$UO/MmTxgNbP6.BV8xKvBd.dvtsq7dkpre/9uGEGPlC0Pg751E69Ia

En usuarios_segura aparecio juan y el campo password_hash con un hash en lugar de la contrasena original

Con la contrasena correcta el resultado fue

    usuario | contraseña_correcta
    juan    | true

Con la contrasena incorrecta el resultado fue

    usuario | contraseña_correcta
    juan    | false

Para comparar los hashes ejecute

    SELECT
        crypt('Password123', gen_salt('bf')) <>
        crypt('Password123', gen_salt('bf'))
        AS hashes_distintos;

El resultado fue

    hashes_distintos
    true

## Analisis

### Que ocurriria si alguien obtiene acceso de lectura a usuarios_insegura

Podria ver la contrasena directamente y tratar de entrar con ella, si esa persona usa la misma en otros sitios tambien podria poner esas cuentas en riesgo

### Son iguales los hashes y por que

No son iguales, al comparar los dos hashes salio true en hashes_distintos, esto pasa porque se usa una sal nueva aunque se escriba la misma contrasena

### Que funcion cumple gen_salt

Genera una sal aleatoria para que la misma contrasena no produzca siempre el mismo resultado

### Que funcion cumple crypt

Genera el hash usando la contrasena y la sal, despues tambien permite calcular el valor para compararlo con el que se guardo

### Esto es cifrado reversible

No, no hay una funcion de descifrado para recuperar la contrasena original

### Que resultado obtuve con la contrasena correcta e incorrecta

Con la correcta salio true y con la incorrecta false

### Por que no es necesario recuperar la contrasena original

Porque se calcula el hash de la contrasena que se intenta usar con la informacion del hash guardado y se comparan los resultados

### Por que un hash no debe confundirse con cifrado

Porque el cifrado permite recuperar el dato con la clave correcta y el hash no se usa para recuperar la contrasena

## Conclusion

La tabla insegura deja ver la contrasena completa, con el hash pude comprobar si era correcta sin recuperar la original, este es un ejemplo de la practica y no un algoritmo que yo haya creado
