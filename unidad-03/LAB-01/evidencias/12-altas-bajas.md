# Actividad 13. Altas y bajas

Estudiante: Osuna Rangel Diego Sebastian


Comando:

    INSERT INTO clientes (nombre, correo, rfc, edad, ciudad, codigo_postal)
    VALUES ('Pedro Ruiz', 'pedro.ruiz@example.test', 'RUPE950101AAA', 30, 'Guasave', '81000');
    DELETE FROM clientes WHERE nombre = 'Pedro Ruiz';

Comando:

    INSERT 0 1
    DELETE 1

Comando:

    SELECT id_evento, usuario_sesion, aplicacion, ip_cliente, operacion, id_cliente,
           valores_antes ->> 'rfc' AS rfc_antes, valores_despues ->> 'rfc' AS rfc_despues
    FROM auditoria.cambios_clientes ORDER BY id_evento;

Resultado:

    id_evento	usuario_sesion	aplicacion	ip_cliente	operacion	id_cliente	rfc_antes	rfc_despues
    1	app_ventas	app-ventas-web	127.0.0.1	UPDATE	3	GAMA780912XYZ	GAMA780912ZZZ
    2	postgres	psql		INSERT	6		RUPE950101AAA
    3	postgres	psql		DELETE	6	RUPE950101AAA	

Pedro Ruiz ya no aparece en clientes, pero la auditoria guardo sus datos al agregarlo y al borrarlo. La IP salio vacia porque se uso una conexion local. Esto tambien significa que la auditoria puede conservar datos que ya se quitaron de la tabla. El tiempo que se guardan lo debe decidir el responsable
