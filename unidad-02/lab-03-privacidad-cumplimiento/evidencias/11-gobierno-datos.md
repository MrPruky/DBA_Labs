# 11 Gobierno de datos

## Objetivo

Repartir quien necesita los datos y quien responde por ellos.

## Procedimiento

Complete la tabla con las areas del ejemplo. No cree esos usuarios en PostgreSQL.

## Resultado

	Dato	Para que	Responsable	Quien lo usa	Como cuidarlo	Hasta cuando	Que hacer al terminar
	nombre	Atencion y factura	Encargados de esas areas	Personal de atencion y facturacion	Mostrarlo solo donde hace falta	Mientras haga falta y el plazo acordado	Revisar si ya se puede borrar
	correo	Contacto por servicio	Atencion	Personal de atencion	Limitar quien lo consulta	Mientras se necesite y el plazo acordado	Quitarlo de los usos terminados y revisar copias
	telefono	Contacto necesario	Atencion	Personal de atencion	No mostrarlo a otras areas sin necesidad	Mientras se necesite y el plazo acordado	Borrarlo cuando corresponda y revisar copias
	rfc	Factura	Facturacion	Personal de facturacion	Permisos y cifrado cuando haga falta	Lo que se revise para facturacion y sus obligaciones	Borrar o bloquear segun lo autorizado
	edad	Conteos por edad	Analitica	Quien prepara rangos; analistas con cantidades	No entregar la edad exacta si no hace falta	Mientras haga falta el dato individual	Guardar solo grupos o borrarlo cuando corresponda
	ciudad	Conteos y tareas que la necesiten	Encargado del area	Personal que la usa; analistas con cantidades	Mostrar solo lo que hace falta	Segun su uso y lo acordado	Revisar si basta guardar los conteos
	codigo_postal	Factura y conteos por zona	Facturacion y analitica	Facturacion; analistas con grupos	No dar el codigo completo si no lo necesitan	Segun su uso y lo acordado	Quitar el codigo completo cuando no haga falta

## Analisis

Atencion necesita contacto, facturacion datos fiscales y analitica cantidades. El area que pide los datos dice para que los quiere. Privacidad y juridico revisan lo necesario y el DBA pone los permisos.

## Conclusion

Trabajar en la empresa no significa necesitar los datos de todas las areas.
