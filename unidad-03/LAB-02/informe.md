# Informe LAB-02 Unidad 3

Estudiante: Osuna Rangel Diego Sebastian

## Como empece

Use MongoDB 7.0.48 Community en Docker con autorizacion. Revise la version y modules, que salio vacio. Community no incluye auditoria nativa; el perfilador y la bitacora no son equivalentes a ella

## Lo que hice y encontre

Primero estaba en nivel 0 y no encontre el cambio de RFC en los registros. Con nivel 2 si aparecieron la consulta, el cambio y el borrado de app_ventas. Despues filtre para guardar modificaciones y la lectura ya no aparecio. Registrar muchas operaciones ocupa espacio y puede guardar datos personales

## Bitacora

El servidor escribe en la salida del contenedor y con getLog revise las lineas recientes. Aparecieron accesos correctos y fallidos. Tambien encontre un cambio del perfilador y lo relacione con la autenticacion de admin por el ctx de la misma conexion

## Privilegios

Tome una copia de los roles antes y otra despues de agregar dbAdmin. Las copias mostraron el cambio, pero no quien lo hizo ni la hora exacta. La busqueda de grantRolesToUser dio 0 en las dos fuentes. Quite el rol adicional al terminar

## Lo que paso al reiniciar

Exporte system.profile y la bitacora antes de reiniciar y calcule sus hashes. Al reiniciar el perfilador volvio a 0, los documentos seguian y la memoria de getLog tenia menos lineas. Los registros tambien se pueden perder al llenarse la coleccion o por rotacion

## Comparacion

En PostgreSQL el disparador del LAB-01 guardo valores anteriores. En Community el perfilador mostro operaciones, pero no el valor anterior y no registro el cambio de privilegios que busque. Las copias ayudan a ver si hubo cambios, pero no dicen quien los hizo

Si una organizacion necesita auditar privilegios recomendaria evaluar auditoria nativa de Enterprise o Atlas y revisar que registre los eventos necesarios. Eso viene en la guia, pero no lo probe en esta practica

## Lo que entendi

1. El perfilador ayuda a seguir operaciones, pero no es una auditoria de seguridad completa
2. Puede mostrar usuario, cliente, aplicacion y hora cuando la operacion queda registrada
3. Nivel 2 puede guardar filtros con datos personales y generar muchos registros
4. Ver que hubo un cambio no siempre demuestra quien lo hizo
5. Hay que decir las limitaciones para no asegurar algo que los registros no prueban
