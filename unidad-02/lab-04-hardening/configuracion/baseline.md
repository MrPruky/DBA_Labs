# Linea base de seguridad

Esta es la comparacion de lo que salio antes y despues. Use PostgreSQL 17.11; la guia usa 16.

## Antes y despues

	Control	Antes	Despues	Por que
	listen_addresses	*	localhost,postgres	Para entrar localmente y desde pgAdmin
	pg_hba.conf	trust local y host all all all	peer local y hostssl con base, usuario e IP	Quitar la entrada sin contraseña y la regla para todos
	Autenticacion	SCRAM por red, trust local	SCRAM por red, peer local	Comprobar tambien quien entra localmente
	Administrador	estudiante con LOGIN y SUPERUSER	Igual	Se usa para administrar la practica
	Cuentas de aplicacion	No se encontraron	Solo propuesta	No hay otra aplicacion conectada aqui
	Puerto	5432, Windows 127.0.0.1	Igual	Otro numero no arregla las reglas
	TLS	on, minimo TLSv1.2; pgAdmin con TLSv1.3	Igual, sin TLS ya no entra por red	Pedir cifrado
	Permisos SO	postgres, carpeta 700 y archivos 600	Igual	Ya estaban limitados
	Extensiones	pgcrypto 1.3, plpgsql 1.0	Igual	Se usan en las practicas
	Conexiones	Maximo 100, reserva 3, statement_timeout 0, espera en transaccion 0	Igual, excepto espera en transaccion 5min	No dejarla esperando sin limite

log_connections y log_disconnections pasaron de off a on.

## Red

Se dejaron la conexion local y la red de Docker para pgAdmin. Antes salian 0.0.0.0:5432 y [::]:5432; despues 127.0.0.1:5432, [::1]:5432 y 172.20.0.2:5432. Para repetir la revision se instalo ss y se uso ss -lnt dentro del contenedor. En Windows sigue 127.0.0.1:5432.

La red privada del ejemplo deja menos equipos con posibilidad de entrar que una base accesible desde Internet. Para el firewall de la actividad 14 puse:

	Origen	Destino	Puerto	Accion
	10.10.10.0/24	10.10.10.20	TCP 5432	Permitir
	Cualquier otro origen	10.10.10.20	TCP 5432	Denegar

Son las IP del ejemplo. No cambie el firewall. Este limita la llegada al puerto; pg_hba.conf tambien revisa base, usuario y forma de entrar.

## Autenticacion

password_encryption dio scram-sha-256. Se usa al poner contraseñas nuevas, no cambia solas las anteriores. estudiante ya tenia SCRAM.

SCRAM comprueba la contraseña usando un dato calculado a partir de ella, en lugar de guardar el texto normal. No se descifra para recuperar la clave. Se prefiere a md5 si el cliente lo soporta. Una cuenta sigue teniendo los mismos permisos aunque su contraseña sea fuerte.

Usaria contraseñas largas, distintas y fuera de Git. Si una se filtra, la cambiaria. La de esta practica se conservo. Para entrar localmente quedo peer, con un mapa de postgres del sistema a estudiante de PostgreSQL. Eso no quita el control que tiene el administrador del equipo sobre Docker y sus archivos.

## Autorizacion

	Rol	LOGIN	SUPERUSER	CREATEROLE	CREATEDB	Funcion
	estudiante	Si	Si	Si	Si	Administrar
	analista	No	No	No	No	Consultar analitica.clientes y public.v_analitica_clientes
	soporte	No	No	No	No	Consultar public.v_clientes_soporte
	15 roles pg_*	No	No	No	No	Vienen con PostgreSQL

La lista esta en [roles-despues.txt](../evidencias/registros/roles-despues.txt). estudiante fue el unico con LOGIN. No quite los roles del motor. analista y soporte pueden ver sus vistas, pero no public.clientes. analista tambien conserva la copia del LAB-01.

Para la actividad 9 repartiria las cuentas asi:

	Cuenta	Para que	LOGIN	Permisos
	DBA	Administrar	Si	Los de administracion
	APP	Conectar la aplicacion	Si	Solo lo que usa, sin SUPERUSER, CREATEDB ni CREATEROLE
	CONSULTA	Ver reportes	Si	SELECT donde se le permita

No cree esas tres cuentas. Si la aplicacion usa la del administrador, un error puede permitir cambiar mas cosas de las que necesita.

## Configuracion

max_connections=100 es el maximo de conexiones. superuser_reserved_connections=3 reserva tres de ese limite para el superusuario. Se dejaron igual; no se hizo una prueba de carga para elegir otros numeros.

statement_timeout=0 no corta las consultas por tiempo. Para una aplicacion revisaria cuanto necesitan durar antes de poner un limite.

idle_in_transaction_session_timeout quedo en 5min. Cierra una sesion que deja una transaccion abierta sin actividad. Dejarla asi puede bloquear otros cambios y gastar recursos.

Deje pgcrypto 1.3 por los hashes y cifrado del LAB-02, y plpgsql 1.0 por las funciones y bloques de las practicas. En otra base revisaria si se usan antes de quitarlas.

## Sistema operativo

Todo esta dentro de /var/lib/postgresql/data:

- Datos: esa misma carpeta.
- Configuracion: postgresql.conf y postgresql.auto.conf.
- Reglas de entrada: pg_hba.conf.
- Mapa de usuarios: pg_ident.conf.
- Clave TLS: lab02-server.key.

La carpeta tiene 700 y los archivos 600, con postgres:postgres. Otros usuarios normales no pueden leerlos. Saber sus rutas sirve para revisarlos y respaldarlos. Los permisos de las tablas no cuidan por si solos los archivos del sistema.

log_directory salio log, pero logging_collector estaba off. Los registros salen por el contenedor y se ven con docker logs. Se activaron los de entrada y salida de conexiones.

## Cifrado

ssl estaba on, minimo TLSv1.2. Las pruebas por red usaron TLSv1.3 y TLS_AES_256_GCM_SHA384. Sin TLS se rechazo la entrada. Por socket local sale ssl=false porque no usa TCP.

La consulta une pg_stat_ssl con pg_stat_activity para mostrar usuario e IP. La prueba con require comprobo cifrado. Para un sistema real tambien revisaria el certificado y verify-full para comprobar que es el servidor correcto. No guardaria claves en Git ni daria acceso a todos los datos solo por tener TLS.

## Mantenimiento

Revisaria cada mes actualizaciones, cuentas, permisos, reglas y certificados. Antes de actualizar guardaria respaldo y probaria en otra instalacion que todo funcione y se pueda recuperar. Aqui no actualice PostgreSQL.

Tambien revisaria los registros y anotaria los cambios. Si se vuelve a crear pgAdmin, puede cambiar su IP y habria que revisar la regla sin perder la entrada local.

Documentacion usada: [conexiones](https://www.postgresql.org/docs/17/runtime-config-connection.html), [tiempos de espera](https://www.postgresql.org/docs/17/runtime-config-client.html) y [pg_hba.conf](https://www.postgresql.org/docs/17/auth-pg-hba-conf.html).
