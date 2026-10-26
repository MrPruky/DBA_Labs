# Informe LAB-04

OSUNA RANGEL DIEGO SEBASTIAN

## 1 Cual era la principal superficie de ataque?

Las conexiones al puerto 5432 y las reglas de entrada. Habia trust local y una regla por red para cualquier equipo que pudiera llegar.

## 2 Que configuracion representaba el mayor riesgo?

trust, porque no pedia contraseña. Tambien estaba de mas la regla para cualquier base y usuario.

## 3 Que cambio redujo mas la exposicion?

Quitar trust y poner la base, usuario e IP que se usan. Despues las pruebas fuera de esas reglas se rechazaron.

## 4 Que diferencia hay entre firewall y pg_hba.conf?

El firewall limita quien llega al puerto. pg_hba.conf revisa la base, usuario, origen y como va a entrar. Ya dentro, los permisos deciden que puede hacer.

## 5 Que diferencia hay entre autenticacion y autorizacion?

Una comprueba quien eres y la otra que te dejan hacer. Entrar con contraseña no significa poder borrar cualquier tabla.

## 6 Por que una aplicacion no debe ser SUPERUSER?

Porque un error de la aplicacion podria dar permiso para cambiar otras cosas de la base. Solo necesita los permisos de su trabajo.

## 7 Por que cambiar el puerto no es suficiente?

Porque seguirian las mismas reglas, solo con otro numero. Los accesos sin permiso seguirian siendo el problema.

## 8 Por que listen_addresses='*' puede ser innecesario?

Porque escucha en todas sus interfaces aunque no las use. Aqui solo hacen falta la local y la de pgAdmin por Docker.

## 9 Que papel tiene el sistema operativo?

Tambien cuida los archivos de la base. Si alguien puede cambiarlos desde el sistema, los permisos SQL no lo evitan. Aqui quedaron con postgres, archivos 600 y carpeta 700.

## 10 Que controles deben revisarse periodicamente?

Las cuentas, permisos, reglas de entrada, puertos, TLS, versiones, registros y respaldos. Tambien volver a probar cuando se cambie algo.

## Caso integral, actividad 18

Estos son los problemas del ejemplo de la guia, no todos estaban en mi instalacion.

	#	Problema	Que puede pasar	Que haria
	1	Cualquier origen IPv4	Mas equipos intentan entrar	Permitir solo los necesarios
	2	Escucha en todas las interfaces	Recibe conexiones donde no hace falta	Elegir donde escucha
	3	Firewall abierto a todos	Cualquiera puede llegar al puerto	Limitar la red permitida
	4	all para las bases	Se intenta entrar a bases que no hacen falta	Poner la base que se usa
	5	all para los usuarios	Se incluyen cuentas de mas	Poner los usuarios necesarios
	6	Aplicacion con cuenta administrativa	Un error permite cambiar mas cosas	Darle su propia cuenta limitada
	7	DBA y aplicacion sin separarse	Cuesta saber quien hizo los cambios	Usar cuentas distintas
	8	Confiar solo en contraseñas fuertes	Una clave robada sigue teniendo todos sus permisos	Revisar tambien red y permisos
	9	No se explica si se exige TLS	Podria haber conexiones sin cifrar	Comprobarlo y pedir TLS
	10	No se explica si se revisan los accesos	Puede no notarse un intento indebido	Guardar y revisar registros

Una contraseña fuerte no cubre todo. Tambien hay que cuidar permisos, red, configuracion y archivos del sistema, y revisar los accesos. Lo de TLS y registros hay que comprobarlo; que no se mencione no significa que este apagado.

## Reflexion

Primero veria quien usa la base y guardaria la configuracion para poder regresar si algo falla. Despues quitaria una entrada sin contraseña o una regla abierta que no se necesita, porque deja intentar entrar a mas equipos.

Antes probaria que los usuarios que si trabajan con la base puedan seguir entrando. Si los bloqueo tambien se para su trabajo. Separaria la cuenta de la aplicacion de la del administrador y revisaria sus permisos. Si hay que reiniciar, acordaria un horario para no cortar el servicio mientras lo usan.
