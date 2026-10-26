# 01 Inventario de datos

## Objetivo

Ver para que hace falta cada campo de clientes.

## Procedimiento

Revise los nueve campos y lo que pide cada area. Habia cinco clientes.

## Resultado

	Campo	Es dato personal	Para que sirve	Hace falta	Quien puede verlo	Hasta cuando guardarlo
	id	Si, esta unido al cliente	Buscarlo y relacionar tablas	Si	Personal que lo necesita y DBA	Mientras se use y por el plazo acordado
	nombre	Si	Atender y facturar	Si para esas tareas	Atencion y facturacion	Mientras haga falta y por el plazo acordado
	correo	Si	Contactar por el servicio	Si se usa ese medio	Atencion	Mientras se use el contacto y el plazo acordado
	telefono	Si	Llamar al cliente	Solo si se necesita	Atencion	Mientras se use y el plazo acordado
	rfc	Si	Hacer la factura	Si pide factura	Facturacion	Lo que se revise para facturacion
	edad	Si, esta unida al cliente	Hacer grupos de edad	Si se necesita esa estadistica	Quien prepara grupos; analitica ve cantidades	Revisar si hace falta despues de contar
	ciudad	Si, esta unida al cliente	Contar clientes por ciudad y otras tareas que la necesiten	Segun la tarea	Area que la usa; analitica ve cantidades	Mientras se use y el plazo acordado
	codigo_postal	Si, esta unido al cliente	Facturacion cuando corresponda y conteos por zona	Segun la tarea	Facturacion; analitica recibe grupos	Segun para que se guardo y el plazo acordado
	fecha_alta	Si, esta unida al cliente	Saber cuando se registro	Si para revisar el registro	Personal que lo necesita y DBA	Mientras se necesite para revisar el registro

## Analisis

id ayuda a buscar al cliente. nombre, correo y telefono sirven para reconocerlo o contactarlo. El RFC hace falta para facturar, no para una duda de soporte.

Para contar se puede usar el grupo de edad, ciudad o parte del codigo postal. fecha_alta sirve para revisar desde cuando esta el registro, pero no decide sola cuando borrarlo. Los tiempos de la tabla son una propuesta; falta que la empresa los acuerde segun sus necesidades y obligaciones.

## Conclusion

No todos necesitan ver todos los campos. Hay que revisar que usa cada area.
