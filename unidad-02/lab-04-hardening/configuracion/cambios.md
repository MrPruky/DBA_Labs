# Cambios realizados

## Revision inicial

Para tomar las capturas se restauro la configuracion anterior y se repitieron las consultas. Despues se volvieron a aplicar los cambios y se tomaron las capturas del despues.

pgAdmin entra desde 172.20.0.3, al host postgres, con practicas y estudiante. La regla que habia era host all all all scram-sha-256: permitia intentar entrar a cualquier base y usuario desde cualquier equipo que pudiera llegar.

La del ejemplo con 0.0.0.0/0 hace eso para todas las IP de IPv4. Se cambio por hostssl practicas estudiante 172.20.0.3/32 scram-sha-256, mas las entradas locales que se usan. Asi no queda una regla para todos.

## Respaldo y autenticacion

Antes se copiaron postgresql.conf, postgresql.auto.conf, pg_hba.conf y pg_ident.conf a:

    /var/lib/postgresql/data/lab04-respaldo-20261026T064148Z

Es una copia de configuracion, no de las tablas. Se registro el 26/10/2026 a las 06:41:48 UTC.

En pg_ident.conf se agrego:

    lab04_admin postgres estudiante

En pg_hba.conf quedaron estas reglas:

    local     all        estudiante                       peer map=lab04_admin
    local     all        all                              reject
    hostnossl all        all          0.0.0.0/0            reject
    hostnossl all        all          ::/0                 reject
    hostssl   practicas  estudiante   172.20.0.3/32        scram-sha-256
    hostssl   practicas  estudiante   127.0.0.1/32         scram-sha-256
    hostssl   practicas  estudiante   ::1/128              scram-sha-256
    host      all        all          0.0.0.0/0            reject
    host      all        all          ::/0                 reject

Se usa la primera regla que coincide. local es para el socket. Las IP con puntos son IPv4 y las que usan :: son IPv6. reject rechaza; las ultimas lineas no permiten entrar a todos. No se dejo entrada de replicacion porque no se usa aqui.

Los archivos siguieron con postgres:postgres y 600. La consulta de reglas dio cero errores antes de recargar.

## Parametros aplicados

Se ejecuto sql/03-configuracion.sql como administrador, sin BEGIN. ALTER SYSTEM guardo los valores en postgresql.auto.conf:

- listen_addresses: localhost,postgres.
- password_encryption: scram-sha-256.
- log_connections y log_disconnections: on.
- idle_in_transaction_session_timeout: 5min.

Se uso pg_reload_conf y se reinicio el contenedor por el cambio de escucha. Siguieron igual el puerto 5432, maximo 100, reserva 3 y statement_timeout=0. Las razones estan en baseline.md. El firewall y las tres cuentas solo quedaron como propuestas.

## Verificacion

Las nueve pruebas estan en [pruebas.txt](../evidencias/registros/pruebas.txt). Entraron las conexiones permitidas con TLS. Se rechazaron otra base, usuario, origen, contraseña incorrecta y conexion sin TLS. Por socket entro postgres del sistema y no root solicitando estudiante.

PostgreSQL respondio despues del reinicio. No quedo reinicio pendiente en lo revisado y los cinco clientes siguieron iguales. La carpeta conservo 700 y los archivos y clave TLS, 600.

Para entrar desde Windows por la terminal se uso:

    docker exec -u postgres postgres-practicas-postgres-1 psql -U estudiante -d practicas

Tambien se comprobo TLS desde el Query Tool de pgAdmin y se guardo su captura. No se probo entrar desde Windows directamente al puerto TCP; puede llegar con otra IP.
