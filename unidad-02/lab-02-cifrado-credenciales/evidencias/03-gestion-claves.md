# 03 Gestion de claves

OSUNA RANGEL DIEGO SEBASTIAN

## Objetivo

Ver el problema de escribir una clave directamente en un archivo SQL y revisar por que no debe subirse una clave real al repositorio

## Comando o procedimiento

Cree y revise el archivo temporal sql/ejemplo-mala-practica.sql con el ejemplo ficticio de la practica

    SELECT pgp_sym_decrypt(
        rfc_cifrado,
        'CLAVE-DE-PRUEBA'
    )
    FROM clientes_protegidos;

Despues borre el archivo temporal y revise que ya no estuviera en la entrega

## Resultado obtenido

La clave se podia leer directamente en el archivo sin ejecutar la consulta, aunque el RFC estuviera cifrado la clave usada para recuperarlo estaba escrita en el mismo codigo

## Analisis

### Que pasaria si fuera una clave real y se publicara en Git

Alguien podria copiar la clave y usarla si consigue los datos cifrados, aunque despues borre la linea la clave puede seguir en el historial

En esta practica CLAVE-DE-PRUEBA es un valor ficticio del ejemplo, una clave real debe guardarse aparte en un gestor de secretos y darse solamente a quien la necesita

Si una clave real se publica hay que tratarla como expuesta, cambiarla y revisar que datos necesitan volver a cifrarse, no basta con borrar la linea del archivo

## Conclusion

No basta con cifrar si dejo la clave escrita junto al codigo, tambien tengo que cuidar quien puede verla
