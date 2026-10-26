# 12 Privacidad por diseño

## Objetivo

Elegir que datos pedir al registrar un cliente.

## Procedimiento

Revise la tabla del ejemplo. No ejecute ese CREATE TABLE.

## Resultado

1. Pide muchos datos sin decir para que. Si se filtran tambien se expone mas informacion. No explica por que pedir edad y fecha de nacimiento a la vez.

2. Se ignoran la minimizacion y la privacidad desde el diseño.

3. Preguntaria para que sirve cada campo, si es obligatorio, quien lo vera, cuanto se guarda y como atender un cambio o solicitud.

4. Quitaria salario, ocupacion y estado civil si el servicio no los necesita. Tampoco pediria edad y fecha de nacimiento sin explicar por que ambas.

5. RFC y direccion fiscal necesitan el motivo de facturacion. La direccion exacta puede hacer falta para entregar algo. Edad o nacimiento necesitan una razon del servicio.

6. Empezaria con pocos datos, permisos limitados y sin activar promociones automaticamente.

## Analisis

Primero hay que saber que servicio se da. No hace falta llenar todos los campos solo porque se pueden guardar. Para probar usaria datos ficticios cuando sea posible.

## Conclusion

Pediria cada dato cuando haya una razon para necesitarlo.
