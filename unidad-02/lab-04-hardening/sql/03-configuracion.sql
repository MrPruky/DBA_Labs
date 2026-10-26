-- LAB-04 configuracion del contenedor de practicas

ALTER SYSTEM SET listen_addresses = 'localhost,postgres';
ALTER SYSTEM SET password_encryption = 'scram-sha-256';
ALTER SYSTEM SET log_connections = 'on';
ALTER SYSTEM SET log_disconnections = 'on';
ALTER SYSTEM SET idle_in_transaction_session_timeout = '5min';

SELECT pg_reload_conf();

