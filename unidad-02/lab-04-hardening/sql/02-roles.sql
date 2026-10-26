-- LAB-04 roles y privilegios
RESET ROLE;

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin
FROM pg_roles
ORDER BY rolname;

SELECT grantee, table_schema, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee IN ('analista', 'soporte')
ORDER BY grantee, table_schema, table_name;

SELECT
    has_table_privilege('analista', 'public.clientes', 'SELECT') AS analista_ve_original,
    has_table_privilege('analista', 'public.v_analitica_clientes', 'SELECT') AS analista_ve_vista,
    has_table_privilege('soporte', 'public.clientes', 'SELECT') AS soporte_ve_original,
    has_table_privilege('soporte', 'public.v_clientes_soporte', 'SELECT') AS soporte_ve_vista;
