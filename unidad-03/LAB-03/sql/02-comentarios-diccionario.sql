COMMENT ON TABLE clientes IS 'Clientes de Comercializadora Norte. Propietario propuesto: Gerencia Comercial. Custodio: DBA. Clasificacion: confidencial.';
COMMENT ON COLUMN clientes.id IS 'Identificador interno del cliente. Generado por el sistema.';
COMMENT ON COLUMN clientes.nombre IS 'Nombre completo. Dato personal identificador.';
COMMENT ON COLUMN clientes.correo IS 'Correo de contacto. Dato personal para notificaciones.';
COMMENT ON COLUMN clientes.telefono IS 'Telefono de contacto del cliente. Dato personal.';
COMMENT ON COLUMN clientes.rfc IS 'RFC del cliente. Dato personal para facturacion. Cambios auditados en auditoria.cambios_clientes.';
COMMENT ON COLUMN clientes.edad IS 'Edad en años cumplidos. Dato personal para analitica.';
COMMENT ON COLUMN clientes.ciudad IS 'Ciudad del cliente. Se usa para atencion y conteos.';
COMMENT ON COLUMN clientes.codigo_postal IS 'Codigo postal del cliente. Se usa para facturacion y conteos.';
COMMENT ON COLUMN clientes.fecha_alta IS 'Fecha en que se registro el cliente.';
COMMENT ON COLUMN clientes.segmento IS 'Segmento asignado al cliente.';
SELECT c.ordinal_position AS pos, c.column_name AS columna, c.data_type AS tipo,
 c.character_maximum_length AS longitud, c.is_nullable AS acepta_nulos, c.column_default AS valor_por_defecto,
 col_description('public.clientes'::regclass,c.ordinal_position) AS descripcion
FROM information_schema.columns c WHERE c.table_schema='public' AND c.table_name='clientes' ORDER BY c.ordinal_position;
