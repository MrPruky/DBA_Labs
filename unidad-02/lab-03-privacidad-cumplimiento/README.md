# LAB-03 - Privacidad, cumplimiento y gobierno de los datos

OSUNA RANGEL DIEGO SEBASTIAN

Gestion de Seguridad y Desempeño de Bases de Datos

## 1 Introduccion

Use la tabla clientes de las practicas anteriores. Aqui revise que datos necesita cada area y cuales no deberia ver.

Trabaje en la base practicas con pgAdmin y psql. Tengo PostgreSQL 17 y la guia usa 16. Los tres SQL estan en sql y las respuestas en evidencias.

## 2 Inventario de datos

La tabla tiene id, nombre, correo, telefono, rfc, edad, ciudad, codigo_postal y fecha_alta. Todos estan relacionados con el cliente.

En [01-inventario-datos.md](evidencias/01-inventario-datos.md) puse para que sirve cada campo y quien lo necesita. Por ejemplo, el RFC sirve para facturar, pero no para resolver una duda de soporte.

## 3 Finalidades

Atencion necesita datos de contacto, facturacion los datos fiscales y analitica cantidades para sus reportes.

Al contar por ciudad salio Culiacan 3, Los Mochis 1 y Mazatlan 1. Por edad salieron cuatro de 30-44 y uno de 45-59. Al agrupar con los dos primeros numeros del codigo postal salio 80 con 3, 81 con 1 y 82 con 1. Es una forma de agrupar para esta practica, no una lista de regiones oficiales.

En [05-finalidad-secundaria.md](evidencias/05-finalidad-secundaria.md) respondi el caso de promociones. Que el cliente de su correo para atenderlo no significa que ya se le pueda mandar publicidad.

## 4 Minimizacion

Cree clientes_soporte con id, nombre, correo y telefono. Salieron los cinco clientes, pero con menos campos.

Para soporte no deje RFC, edad ni codigo postal porque no hacen falta para esa tarea. Eso es la minimizacion: usar los datos que si se necesitan.

## 5 Control de acceso

Use el rol analista y le di permiso para ver v_analitica_clientes. Al consultar la vista salieron ciudad y rango de edad. Al intentar consultar public.clientes salio permission denied for table clientes.

analista tambien conserva acceso a analitica.clientes del LAB-01. La vista nueva no muestra nombres ni correos, pero sigue teniendo una fila por cliente. Para solo hacer estadisticas bastan los conteos; quitar nombres no asegura que nadie pueda reconocer a una persona.

## 6 Derechos ARCO

Acceso: busque a Ana por ana.lopez@example.test y salio id 1. Antes de entregar datos de alguien hay que comprobar quien los pide. Tambien hay que explicar para que se usan, de donde salieron, con quien se comparten y cuanto se guardan.

Rectificacion: cambie su correo a nuevo-correo@example.com. Despues consulte clientes_soporte y ahi seguia el correo anterior. La copia no se actualizo sola. El SQL comprueba el correo viejo antes de cambiarlo, asi que al repetirlo ya no vuelve a hacer ese cambio.

Para un cambio real guardaria la solicitud, quien lo autorizo, quien lo hizo y cuando. Aqui no se creo una tabla para registrar eso.

Cancelacion: no borre al cliente. Primero revise sus copias y relaciones. El mapa esta en [08-ciclo-vida.md](evidencias/08-ciclo-vida.md). Los respaldos y otros destinos que no se comprobaron quedaron marcados como por revisar.

Oposicion: si no quiere promociones, se pueden dejar de usar sus datos para eso sin borrar lo que aun haga falta para atenderlo o facturar. La empresa tiene que revisar la solicitud; el DBA hace el cambio que se autorice.

## 7 Retencion

No elegi la misma cantidad de años para todo. Primero hay que revisar para que sigue haciendo falta cada dato y si hay una obligacion de guardarlo. Despues se decide el tiempo y que hacer al terminar, incluyendo las copias.

Las respuestas estan en [10-retencion.md](evidencias/10-retencion.md).

## 8 Gobierno de datos

	Area	Que hace
	Responsable del area	Dice para que necesita los datos
	Privacidad	Da seguimiento a su uso y a las solicitudes
	Juridico	Revisa las obligaciones
	DBA	Hace los cambios y pone los permisos autorizados

La tabla por campo esta en [11-gobierno-datos.md](evidencias/11-gobierno-datos.md). Son responsabilidades propuestas, no usuarios que cree en PostgreSQL.

Para la actividad 13 puse:

	Medida	Tecnico	Administrativo	Por que
	Crear roles	Si	No	Se hace en PostgreSQL
	Politica de retencion	No	Si	Decide cuanto guardar los datos
	Cifrado	Si	No	Se aplica con tecnologia
	Procedimiento ARCO	No	Si	Organiza como atender la solicitud
	Vista limitada	Si	No	Muestra menos datos
	Clasificacion de informacion	Puede intervenir	Si	Se deciden categorias y se pueden usar etiquetas en el sistema
	Registro de auditoria	Si	No	Guarda lo que se hizo
	Politica de acceso	No	Si	Decide quien debe tener permiso

Las reglas se deciden en la empresa y despues se aplican en el sistema. Los registros tambien necesitan alguien que los revise. En [12-privacidad-diseno.md](evidencias/12-privacidad-diseno.md) respondi que datos pediria al registrar al cliente.

## 9 Evaluacion integral

En el caso de los 50000 clientes hay datos de mas para analitica, copias reales para pruebas y doce años de datos sin un tiempo de conservacion explicado.

Los diez problemas estan en [14-evaluacion-integral.md](evidencias/14-evaluacion-integral.md). La propuesta de separar los datos esta en [15-arquitectura.md](evidencias/15-arquitectura.md); solo se hizo el dibujo y la explicacion.

## 10 Conclusiones

La copia de soporte me sirvio para ver que cambiar la tabla original no cambia todas las copias. Tambien se pudo trabajar con menos campos y hacer conteos sin mostrar nombres. Antes de dar datos a otra area hay que revisar para que los va a usar.

Preguntas de reflexion:

1. Una base tecnicamente segura cumple con toda la privacidad?

   No, puede tener permisos y aun asi guardar datos que no necesita.

2. Por que el minimo privilegio ayuda a la privacidad?

   Porque cada persona ve solo los datos que necesita para su tarea.

3. Por que el DBA no debe decidir solo la finalidad?

   Porque el uso lo decide la empresa con las areas responsables. El DBA se encarga de la parte de la base.

4. Por que desarrollo no debe recibir copias completas automaticamente?

   Porque para probar algo no siempre hacen falta los datos reales de todos. Se pueden usar datos de prueba.

5. Por que una copia de desarrollo tambien es un riesgo?

   Porque sigue teniendo datos de personas y tambien puede filtrarse.

6. Por que la retencion forma parte del ciclo de vida?

   Porque hay que decidir cuando dejar de guardar los datos y sus copias.

7. Que relacion tiene privacidad por diseño con la base?

   Que desde que se eligen los campos se piensa para que hace falta cada uno.

8. Que controles tecnicos usaria?

   Permisos, vistas con menos campos, conteos, cifrado y registro de cambios. Tambien revisar las copias.

9. Que debe saber el DBA para una solicitud ARCO?

   De que cliente se trata, donde estan sus datos y que cambio se autorizo. Tambien si hay algo que deba conservarse.

10. Que responsabilidad tiene cada area?

    El DBA hace los cambios, privacidad sigue la solicitud, juridico revisa obligaciones y el area que usa los datos explica para que los necesita.
