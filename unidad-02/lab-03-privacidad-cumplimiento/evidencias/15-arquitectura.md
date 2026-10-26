# 15 Propuesta de arquitectura

## Objetivo

Dibujar como separaria los datos para cada area.

## Procedimiento

Hice la propuesta del ejemplo, no cree todo ese sistema.

## Resultado

    Base de datos
      +-- Operacion: soporte y facturacion
      +-- Analitica: cantidades y grupos
      +-- Auditoria: accesos y cambios

Acceso: un rol por funcion, con lo que necesita.

Minimizacion: contacto para soporte, datos fiscales para facturar y conteos para analitica.

Proteccion: limitar datos sensibles, cifrado cuando haga falta y TLS. Claves aparte.

Retencion: decidir cuanto guardar, incluyendo copias y respaldos.

Trazabilidad: anotar quien pidio, autorizo e hizo el cambio y cuando.

Eliminacion: buscar copias y relaciones, hacer lo autorizado y comprobarlo.

ARCO: comprobar a quien corresponde la solicitud, buscar sus datos y darle seguimiento.

## Analisis

clientes_soporte no cambio cuando se corrigio el correo original. Si se necesita ver el dato actual, usaria una vista o un proceso que actualice la copia. Para estadisticas revisaria si bastan cantidades en lugar de una fila por persona.

## Conclusion

Hacer mas tablas no basta. Tambien hay que cuidar las copias y saber quien usa los datos.
