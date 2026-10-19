# 04 Proteccion de las comunicaciones con TLS

OSUNA RANGEL DIEGO SEBASTIAN

## Objetivo

Revisar si la conexion a PostgreSQL usa TLS y activarlo para que los datos no viajen sin cifrado

## Comando o procedimiento

Primero revise el estado del servidor y de mi conexion en pgAdmin

    SELECT
        current_setting('ssl') AS tls_en_servidor,
        ssl AS tls_en_esta_conexion,
        version,
        cipher
    FROM pg_stat_ssl
    WHERE pid = pg_backend_pid();

Resultado inicial

    tls_en_servidor | tls_en_esta_conexion | version | cipher
    off            | false                | NULL    | NULL

Como estaba apagado cree un certificado de prueba dentro del contenedor desde PowerShell

    docker exec -u postgres postgres-practicas-postgres-1 sh -c 'umask 077; openssl req -new -x509 -days 365 -nodes -newkey rsa:2048 -out $PGDATA/lab02-server.crt -keyout $PGDATA/lab02-server.key -subj /CN=localhost -addext subjectAltName=DNS:localhost,IP:127.0.0.1'

Despues ejecute estas instrucciones una por una en pgAdmin

    RESET ROLE;
    ALTER SYSTEM SET ssl_cert_file = 'lab02-server.crt';
    ALTER SYSTEM SET ssl_key_file = 'lab02-server.key';
    ALTER SYSTEM SET ssl = 'on';
    SELECT pg_reload_conf();
    SHOW ssl;

SHOW ssl mostro on, tambien revise estos parametros

    SHOW ssl;
    SHOW ssl_min_protocol_version;
    SHOW port;
    SHOW listen_addresses;

Los resultados fueron on, TLSv1.2, 5432 y *, tambien los consulte juntos para verlos en una sola fila

    SELECT
        current_setting('ssl') AS ssl,
        current_setting('ssl_min_protocol_version') AS version_minima,
        current_setting('port') AS puerto,
        current_setting('listen_addresses') AS direcciones;

    ssl | version_minima | puerto | direcciones
    on  | TLSv1.2        | 5432   | *

Despues abri una conexion nueva desde PowerShell

    docker exec -it postgres-practicas-postgres-1 psql "host=localhost port=5432 dbname=practicas user=estudiante sslmode=require"

Dentro de psql ejecute

    SELECT ssl, version, cipher
    FROM pg_stat_ssl
    WHERE pid = pg_backend_pid();

## Resultado obtenido

En la conexion nueva de psql con sslmode=require obtuve

    ssl | version | cipher
    t   | TLSv1.3 | TLS_AES_256_GCM_SHA384
    (1 row)

Despues ejecute las consultas del archivo 03 en pgAdmin, la direccion y el puerto del cliente en esa sesion fueron

    SELECT inet_client_addr(), inet_client_port();

    inet_client_addr | inet_client_port
    172.20.0.3       | 49366

El puerto del cliente es de esa conexion, no es el puerto 5432 donde escucha el servidor y puede cambiar al conectarse otra vez

Al revisar pg_stat_ssl en esa sesion de pgAdmin obtuve

    ssl   | version | cipher
    false | NULL    | NULL

## Analisis

Al principio mi conexion no usaba TLS, despues de activarlo y conectarme con psql aparecio t, que significa true, tambien aparecieron la version TLSv1.3 y el cifrado TLS_AES_256_GCM_SHA384

En pgAdmin siguio saliendo false, esa conexion no estaba usando TLS aunque ya estuviera activo en el servidor, no cambie las reglas para bloquear todas las conexiones sin TLS

La version minima configurada es TLSv1.2 y la conexion uso TLSv1.3, son datos diferentes, una indica el minimo que acepta el servidor y la otra lo que se uso en esa conexion

SHOW ssl indica si el servidor tiene TLS habilitado, pero para comprobar mi conexion revise pg_stat_ssl con el pid de mi sesion

Use sslmode=require para exigir una conexion cifrada, eso no demuestra una validacion completa de la identidad del servidor, verify-ca valida el certificado contra una autoridad de confianza y verify-full tambien revisa el nombre del servidor

Use un certificado autofirmado para esta prueba, no uno emitido por una autoridad de confianza

## Conclusion

La conexion nueva de psql si usa TLS y la sesion revisada de pgAdmin no, activar TLS en el servidor no obliga a todos los clientes a usarlo, se debe comprobar cada conexion, TLS protege los datos mientras viajan pero no reemplaza los permisos de PostgreSQL ni protege por si solo los datos guardados
