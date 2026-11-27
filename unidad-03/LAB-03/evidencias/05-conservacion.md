# Actividad 5. Conservacion

Los tiempos son una propuesta para la practica, no plazos legales. Antes de aplicarlos hay que revisar con juridico y privacidad si hay alguna obligacion o investigacion pendiente

    Registro	Ubicacion y riesgo	Sensibilidad	Periodo y motivo	Donde y quien lo lee	Al vencer
    Accesos PostgreSQL	Archivo del colector; rota	Alta	90 dias para revisiones	Copia externa; seguridad y auditoria	Revisar bloqueo legal y eliminar autorizado
    Privilegios y estructura	Archivo del colector; rota	Alta	1 año para comparar cambios	Copia externa; seguridad y auditoria	Revisar y eliminar autorizado
    Modificaciones PostgreSQL	Archivo del colector; puede perderse	Alta, puede incluir datos	90 dias para investigar	Copia externa; auditoria	Revisar y eliminar autorizado
    auditoria.cambios_clientes	Tabla; depende del servidor	Alta, contiene valores	1 año para investigar cambios	Base y copia protegida; auditoria	Evaluar privacidad, bloqueo y borrado autorizado
    Bitacora mongod	Salida del contenedor/getLog; memoria limitada	Alta	90 dias exportada	Copia externa; seguridad y auditoria	Revisar y eliminar autorizado
    system.profile	Coleccion limitada; se sobrescribe	Alta, puede contener consultas	90 dias exportado	Copia externa; auditoria	Revisar y eliminar autorizado
    Instantaneas privilegios MongoDB	Coleccion auditoria; puede perderse	Alta	1 año para comparar roles	Copia externa; auditoria	Revisar y eliminar autorizado

Los cambios de permisos pueden necesitar mas tiempo de revision que las consultas normales. Usaria SHA-256 para saber si cambio una copia y guardaria el hash aparte. Un log ayuda a investigar y un respaldo sirve para recuperar datos. Antes de borrar tambien hay que revisar si los datos siguen en la auditoria o en copias
