# Actividad 2. Responsables

Use la matriz de la Unidad 2, LAB-03, evidencia 11. Los responsables son una propuesta para la practica

    Datos	Propietario propuesto	Custodio	Usuarios	Quien aprueba acceso	Quien aprueba correcciones
    public.clientes	Gerencia Comercial; Atencion para contacto y Facturacion para RFC	DBA	Ventas y soporte segun permiso	Area propietaria	Area responsable del dato
    auditoria.cambios_clientes	Auditoria interna	DBA	Auditoria autorizada	Auditoria interna	Auditoria interna
    Bitacora PostgreSQL	Seguridad y auditoria	DBA	Auditoria autorizada	Seguridad y auditoria	No modificar; registrar una aclaracion
    MongoDB comercial.clientes	Gerencia Comercial	DBA	Aplicacion de ventas	Gerencia Comercial	Area responsable del dato
    MongoDB system.profile	Seguridad y auditoria	DBA	Auditoria autorizada	Seguridad y auditoria	No modificar; registrar una aclaracion

Auditoria debe poder revisar los registros sin depender solo de quien trabaja con clientes. La bitacora puede tener datos personales o contraseñas, por eso no todos deben verla. Si nadie es responsable del dato, no se sabe quien autoriza su uso o correccion
