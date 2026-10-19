-- LAB-02 TLS

-- 11

SHOW ssl;

SHOW ssl_min_protocol_version;

SHOW port;

SHOW listen_addresses;

-- 11.1
SELECT
    inet_client_addr(),
    inet_client_port();

SELECT
    ssl,
    version,
    cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();

-- configuracion
SELECT
    current_setting('ssl') AS ssl,
    current_setting('ssl_min_protocol_version') AS version_minima,
    current_setting('port') AS puerto,
    current_setting('listen_addresses') AS direcciones;
