-- LAB-04 verificacion
RESET ROLE;

SELECT name, setting, unit, pending_restart
FROM pg_settings
WHERE name IN (
    'port', 'listen_addresses', 'ssl', 'ssl_min_protocol_version',
    'password_encryption', 'max_connections', 'superuser_reserved_connections',
    'statement_timeout', 'idle_in_transaction_session_timeout',
    'log_connections', 'log_disconnections'
)
ORDER BY name;

SELECT line_number, type, database, user_name, address, netmask, auth_method, error
FROM pg_hba_file_rules
ORDER BY line_number;

SELECT COUNT(*) AS errores_hba
FROM pg_hba_file_rules
WHERE error IS NOT NULL;

SELECT s.pid, a.usename, a.client_addr, s.ssl, s.version, s.cipher
FROM pg_stat_ssl s
JOIN pg_stat_activity a ON a.pid = s.pid
WHERE s.pid = pg_backend_pid();

SELECT a.pid, a.usename, a.datname, a.client_addr, a.application_name,
       s.ssl, s.version, s.cipher
FROM pg_stat_activity a
JOIN pg_stat_ssl s ON s.pid = a.pid
WHERE a.client_addr IS NOT NULL
ORDER BY a.pid;

SELECT extname, extversion FROM pg_extension ORDER BY extname;
SELECT COUNT(*) AS clientes FROM public.clientes;

