# LAB-04 - Hardening y configuracion segura de PostgreSQL

OSUNA RANGEL DIEGO SEBASTIAN

Gestion de Seguridad y Desempeño de Bases de Datos

## Objetivo

Revisar quien podia conectarse a PostgreSQL, cambiar lo que estaba de mas y probar que siguiera funcionando.

## Entorno

Use la base practicas con Docker, pgAdmin y psql. Tengo PostgreSQL 17.11 y la guia usa 16. Dentro de Docker, PostgreSQL tiene 172.20.0.2 y pgAdmin 172.20.0.3. En Windows el puerto esta en 127.0.0.1:5432.

Los SQL estan en sql. El antes y despues esta en [baseline.md](configuracion/baseline.md) y las preguntas en [informe.md](informe.md).

## Superficie de ataque inicial

	Elemento	Como estaba	Hace falta	Riesgo
	Puerto	5432 en localhost de Windows	Si	El puerto no decide quien entra
	Donde escucha	* dentro de Docker	Solo local y para pgAdmin	Escuchar donde no se necesita
	Conexion desde otro equipo	pgAdmin, pero la regla permitia cualquier origen	Solo los que se usan	Que otros equipos intenten entrar
	Administrador	estudiante con LOGIN y SUPERUSER	Si, para la practica	Con esa cuenta se puede cambiar todo
	TLS	on, minimo TLSv1.2; pgAdmin usaba TLSv1.3	Si	Que otra conexion entre sin cifrar
	Autenticacion	trust local y SCRAM con all/all/all por red	Si hay que comprobar quien entra	trust no pide contraseña

Primero revise esto para no cambiar una regla que necesitaba pgAdmin. El * era dentro del contenedor; el puerto de Windows no estaba publicado para todos.

## Hallazgos

trust dejaba entrar localmente sin contraseña. Tambien habia una regla de red para cualquier base, usuario y equipo que pudiera llegar.

Los permisos de archivos ya estaban limitados. Deje pgcrypto y plpgsql porque se usan en las practicas. No se estaban guardando las entradas y salidas de conexiones ni habia tiempo limite para una transaccion sin actividad.

## Cambios realizados

Quite trust. Para entrar desde pgAdmin quedaron su IP, la base practicas y estudiante, con contraseña y TLS. Tambien quedo la entrada local; por socket se usa postgres del sistema con peer. Lo demas se rechaza.

listen_addresses quedo en localhost,postgres. Se activaron los registros de conexiones y se pusieron cinco minutos para una transaccion sin actividad. Antes se guardo la configuracion y despues se reinicio PostgreSQL. Las reglas completas estan en [cambios.md](configuracion/cambios.md).

## Justificacion de los cambios

pgAdmin esta en otro contenedor, por eso necesita la red de Docker. Dejar solo localhost le quitaria esa entrada.

No cambie 5432 ni el maximo de 100 conexiones, porque no hice pruebas para elegir otro limite. statement_timeout quedo en 0, sin cortar consultas por tiempo. Esos valores se explican en baseline.md.

## Verificacion

Pasaron las nueve pruebas. Las conexiones permitidas entraron y las otras se rechazaron. Se probo otra base, otro usuario, otro origen, contraseña incorrecta, sin TLS y entrada local como root.

La prueba desde el contenedor pgAdmin uso TLSv1.3 y TLS_AES_256_GCM_SHA384. Las reglas dieron cero errores, no quedo reinicio pendiente en lo revisado y los cinco clientes siguieron iguales.

Las seis imagenes de evidencias son capturas reales de pgAdmin y PowerShell. Todas las capturas del antes y despues estan en [evidencias/capturas](evidencias/capturas). Los registros de terminal estan en [evidencias/registros](evidencias/registros). Por socket local sale ssl=false porque no usa TCP; la prueba de TLS fue por red.

## Checklist de hardening

	#	Que revise	Resultado	Evidencia
	1	Puerto	5432	01 y 02
	2	Donde escucha	Local y red de Docker	02
	3	pg_hba.conf	Sin errores	03
	4	Equipos permitidos	Solo los de las reglas	03 y 06
	5	Autenticacion	SCRAM por red, peer local	03 y 04
	6	SUPERUSER	estudiante	04
	7	DBA, APP y CONSULTA	Solo propuesta	baseline.md
	8	analista y soporte	Vistas si, tabla original no	04
	9	Extensiones	pgcrypto y plpgsql	baseline.md
	10	TLS	Entro con TLS, sin TLS no	05
	11	Archivos	postgres:postgres, 600	registros de permisos
	12	Carpeta de datos	postgres:postgres, 700	registros de permisos
	13	Firewall	Solo propuesta	baseline.md
	14	Actualizaciones	Plan escrito, no se actualizo	baseline.md
	15	Cambios y pruebas	Guardados	cambios.md y 06

## Conclusiones

Con las pruebas se vio la diferencia: pgAdmin pudo entrar y los intentos fuera de las reglas no. Se quito el acceso sin contraseña de trust. Cambiar solo el puerto o la contraseña no habria cambiado la regla que permitia a todos.
