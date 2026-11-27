# Actividad 3. Diccionario

Use los COMMENT de sql/02-comentarios-diccionario.sql y consulte la tabla. El resultado esta en diccionario-clientes.csv. La columna canal_alta la agregue despues en la actividad 7

    Columna	Clasificacion	Para que	Control propuesto	Cambio auditado	Calidad
    id	Interno	Identificar	Permisos	Si	Unico y no nulo
    nombre	Dato personal	Identificar	Permisos	Si	No vacio
    correo	Dato personal	Contacto	Permisos por funcion	Si	Formato y unicidad
    telefono	Dato personal	Contacto	Permisos por funcion	Si	Formato por confirmar
    rfc	Dato personal	Facturacion	Acceso limitado	Si	Formato para practica
    edad	Dato personal	Analitica	Usar grupos cuando sea posible	Si	Rango 18 a 120 para esta prueba
    ciudad	Dato personal segun contexto	Atencion y conteos	Acceso limitado	Si	Valor valido
    codigo_postal	Dato personal segun contexto	Facturacion y zona	Acceso limitado	Si	Formato por confirmar
    fecha_alta	Interno	Registro	Permisos	Si	Fecha valida
    segmento	Interno	Clasificacion comercial	Permisos	Si	Lista acordada
    canal_alta	Interno	Origen del registro	Permisos	Si	Lista acordada

Los COMMENT ayudan a ver que significa cada columna desde la base. En E5-bitacora-postgresql.log aparecen los COMMENT con log_statement en mod. Los responsables, plazos y decisiones tambien se deben guardar fuera de la base y revisar con las areas correspondientes
