# Actividad 15. Lecturas y volumen

Estudiante: Osuna Rangel Diego Sebastian


Prueba:

    psql por TCP, soporte_ana@127.0.0.1/comercial, app=psql
    SELECT nombre, rfc, telefono FROM clientes WHERE id = 3

Resultado:

    nombre	rfc	telefono
    María García	GAMA780912GHI	6679990000

Comando:

    UPDATE clientes SET segmento = 'regular';

Comando:

    UPDATE 5

Comando:

    SELECT count(*) AS lineas_bitacora FROM dba.bitacora
    WHERE linea LIKE '%statement: UPDATE clientes SET segmento%';

Resultado:

    lineas_bitacora
    1

Comando:

    SELECT operacion, count(*) FROM auditoria.cambios_clientes GROUP BY operacion ORDER BY operacion;

Resultado:

    operacion	count
    DELETE	1
    INSERT	1
    UPDATE	6

Comando:

    SELECT count(*) AS lecturas_soporte FROM dba.bitacora
    WHERE linea LIKE '%user=soporte_ana%SELECT nombre, rfc%';

Resultado:

    lecturas_soporte
    0

El UPDATE cambio cinco clientes. En la bitacora quedo una linea y en la auditoria cinco filas nuevas. Si fueran un millon de clientes, se guardarian un millon de filas y se usaria mas espacio. La lectura no quedo registrada con mod. Antes de borrar auditoria tendria que autorizarlo el responsable con auditoria o cumplimiento. Con all tambien podrian quedar RFC, telefonos y otros datos dentro del log
