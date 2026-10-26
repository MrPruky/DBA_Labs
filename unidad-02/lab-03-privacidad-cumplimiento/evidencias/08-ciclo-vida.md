# 08 Cancelacion y ciclo de vida

## Objetivo

Revisar donde mas pueden quedar datos de un cliente.

## Procedimiento

Revise copias, vistas y relaciones. No hice DELETE.

## Resultado

    clientes
      +-- clientes_soporte, copia
      +-- analitica.clientes, copia del LAB-01
      +-- pii.mapa_cliente, relacionada por clave foranea
      +-- v_clientes_soporte, vista
      +-- v_analitica_clientes, vista
      +-- respaldos y replicas, por revisar
      +-- reportes y archivos exportados, por revisar
      +-- otros sistemas, por revisar

El correo de Ana quedo en nuevo-correo@example.com en clientes. En clientes_soporte seguia ana.lopez@example.test. Los destinos marcados como por revisar no se comprobaron en esta practica.

## Analisis

Una copia puede seguir teniendo el dato aunque cambie el original. Antes de borrar hay que ver donde esta, que se autorizo y que debe conservarse. Recuperar un respaldo tambien puede traer de vuelta datos que ya se habian retirado.

## Conclusion

Borrar una fila no significa borrar todas sus copias.
