-- LAB-04 inspeccion
RESET ROLE;

SELECT version();
SHOW port;
SHOW listen_addresses;
SHOW ssl;
SHOW password_encryption;

SELECT pid, usename, datname, client_addr, client_port, application_name
FROM pg_stat_activity
ORDER BY pid;

SHOW config_file;
SHOW hba_file;
SHOW ident_file;
SHOW data_directory;
SHOW log_directory;
SHOW logging_collector;
SHOW log_connections;
SHOW log_disconnections;

SELECT line_number, type, database, user_name, address, netmask, auth_method, error
FROM pg_hba_file_rules
ORDER BY line_number;

SELECT extname, extversion
FROM pg_extension
ORDER BY extname;

SHOW max_connections;
SHOW superuser_reserved_connections;
SHOW statement_timeout;
SHOW idle_in_transaction_session_timeout;
SHOW ssl_min_protocol_version;

SELECT s.pid, a.usename, a.client_addr, s.ssl, s.version, s.cipher
FROM pg_stat_ssl s
JOIN pg_stat_activity a ON a.pid = s.pid
WHERE s.pid = pg_backend_pid();
