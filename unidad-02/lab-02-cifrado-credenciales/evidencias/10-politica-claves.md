# 10 Politica minima de proteccion de claves

OSUNA RANGEL DIEGO SEBASTIAN

## Objetivo

Escribir reglas para cuidar las claves y saber que hacer si se pierden o alguien las obtiene

## Comando o procedimiento

Escribi ocho reglas sobre como crear, guardar, usar, cambiar y borrar las claves, son una propuesta para la practica

## Resultado obtenido

1. Generar las claves con una herramienta criptografica y valores aleatorios, no usar palabras faciles ni inventar una clave corta

2. Guardarlas en un gestor de secretos separado de los scripts y del repositorio, no escribirlas directamente en el codigo

3. Dar acceso solo a las personas y servicios que las necesitan, registrar su uso y revisar los permisos

4. Cambiar las claves segun un periodo definido y tambien cuando se sospeche que alguien mas las obtuvo, planear el cambio para que los datos sigan pudiendo recuperarse

5. Tener un respaldo protegido de las claves que se necesitan para recuperar informacion, limitar su acceso y probar la recuperacion

6. Retirar el acceso cuando una persona o servicio ya no lo necesita, marcar las claves comprometidas para que no sigan usandose para nuevos datos

7. Si se publica una clave por error avisar al responsable y cambiarla, revisar que datos protegia y volver a cifrarlos cuando corresponda, borrar el archivo del repositorio no soluciona por si solo la exposicion

8. Eliminar de forma segura las claves y sus copias cuando ya no sean necesarias, antes revisar que no se necesiten para recuperar datos o respaldos que todavia deban conservarse

## Analisis

Aunque el cifrado funcione no sirve dejar la clave donde cualquiera la vea, tambien puedo perder los datos si pierdo la unica clave que los recupera

## Conclusion

Hay que cuidar las claves desde que se crean hasta que se dejan de usar, tambien tener claro quien puede verlas y como recuperarlas
