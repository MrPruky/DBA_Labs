# Actividad 1. Configuracion inicial

Estudiante: Osuna Rangel Diego Sebastian


Use PostgreSQL 16.15 en Docker. En local salio trust y en las conexiones por red salio scram-sha-256. Por eso no cambie pg_hba.conf. Con trust no se pide contraseña, asi que el nombre que alguien escribe no comprueba quien es

Comando:

    SELECT line_number, type, database, user_name, address, auth_method
    FROM pg_hba_file_rules
    WHERE database = '{all}';

Resultado:

    line_number	type	database	user_name	address	auth_method
    117	local	{all}	{all}		trust
    119	host	{all}	{all}	127.0.0.1	scram-sha-256
    121	host	{all}	{all}	::1	scram-sha-256
    128	host	{all}	{all}	all	scram-sha-256

Comando:

    SELECT name, setting, source
    FROM pg_settings
    WHERE name IN ('log_destination', 'logging_collector', 'log_directory', 'log_filename',
                   'log_connections', 'log_disconnections', 'log_line_prefix',
                   'log_statement', 'log_min_error_statement', 'log_timezone')
    ORDER BY name;

Resultado:

    name	setting	source
    log_connections	off	default
    log_destination	stderr	default
    log_directory	log	default
    log_disconnections	off	default
    log_filename	postgresql-%Y-%m-%d_%H%M%S.log	default
    logging_collector	off	default
    log_line_prefix	%m [%p]	default
    log_min_error_statement	error	default
    log_statement	none	default
    log_timezone	Etc/UTC	configuration file

Al principio las conexiones estaban en off y log_statement en none. Por eso no se guardaban las conexiones ni un UPDATE que terminara bien. Un error si podia quedar registrado. El prefijo solo mostraba hora y PID, no usuario ni IP. La hora estaba en UTC; eso importa para no confundirla con la hora local. Como el colector estaba apagado, PostgreSQL mandaba la salida a Docker
