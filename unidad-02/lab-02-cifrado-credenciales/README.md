# LAB-02 - Cifrado, credenciales y comunicaciones seguras

OSUNA RANGEL DIEGO SEBASTIAN

Gestion de Seguridad y Desempeno de Bases de Datos

Unidad II, Seguridad, privacidad y control de acceso

Herramientas, PostgreSQL 17, pgAdmin, Docker y psql

## 1 Introduccion

En esta practica use la misma base practicas del laboratorio anterior, primero revise como se guardan las contrasenas, despues cifre un RFC de prueba y active TLS para proteger la conexion

Tener usuarios y permisos no resuelve todo, tambien se debe cuidar como se guardan los datos, como viajan y donde estan las claves

## 2 Proteccion de credenciales

Cree usuarios_insegura y guarde el usuario juan con la contrasena ficticia Password123, al consultar la tabla se podia leer completa, si alguien obtiene acceso de lectura tambien podria copiarla

Despues use pgcrypto y cree usuarios_segura con password_hash, ahi se guarda un hash en lugar de la contrasena original

Al generar dos hashes de la misma contrasena y compararlos salio true en hashes_distintos, esto paso porque gen_salt genera una sal nueva

Para comprobar la contrasena compare el hash guardado con el calculado usando crypt, con Password123 salio true y con OtraPassword salio false

Texto claro es el dato que se puede leer directamente, el hash sirve para comprobar una contrasena sin recuperarla y el cifrado permite recuperar un dato usando una clave, por eso no son lo mismo

Evidencia, [01-credenciales.md](evidencias/01-credenciales.md)

## 3 Proteccion de datos sensibles

Cree clientes_protegidos y guarde un RFC ficticio con pgp_sym_encrypt, la columna rfc_cifrado es de tipo bytea y pgAdmin la mostro como datos binarios

Con pgp_sym_decrypt y la clave correcta pude recuperar el RFC del ejemplo, con otra clave aparecio Wrong key or corrupt data

Use el RFC porque es un dato que puede identificar al cliente y que puede necesitar recuperarse, por eso en este caso se usa cifrado en lugar de un hash

El nombre sigue visible y la tabla clientes sigue igual, solo cifre el RFC del ejemplo en la tabla nueva

Evidencia, [02-cifrado-datos.md](evidencias/02-cifrado-datos.md)

## 4 TLS

Primero revise mi conexion y aparecio ssl off en el servidor y false en la sesion, la version y el cifrado estaban vacios

Cree un certificado de prueba dentro del contenedor, configure las rutas y active ssl con ALTER SYSTEM, despues recargue la configuracion

SHOW ssl mostro on, tambien revise la version minima, el puerto y las direcciones donde escucha PostgreSQL

| Configuracion | Resultado |
|---|---|
| ssl | on |
| ssl_min_protocol_version | TLSv1.2 |
| port | 5432 |
| listen_addresses | * |

Despues entre desde PowerShell con psql y sslmode=require, la consulta a pg_stat_ssl mostro

    ssl | version | cipher
    t   | TLSv1.3 | TLS_AES_256_GCM_SHA384

Con eso comprobe que esa conexion si estaba cifrada, tener ssl en on no significa que todas las sesiones ya lo esten usando, por eso revise la conexion nueva

En pgAdmin salio la direccion 172.20.0.3 y el puerto 49366, ahi siguio saliendo false y los otros campos vacios, la conexion que si comprobe con TLS fue la de psql

El puerto 49366 pertenece al cliente de esa sesion y puede cambiar, el servidor escucha en 5432

El certificado es autofirmado y sirve para esta prueba, require exige TLS pero no demuestra una validacion completa de la identidad, verify-ca valida la autoridad del certificado y verify-full tambien revisa el nombre del servidor

Los modos no son iguales, disable no usa TLS, prefer intenta usarlo pero permite continuar sin el, require lo exige y verify-ca y verify-full agregan validacion del certificado

TLS protege la informacion mientras viaja, no cambia los permisos de los usuarios ni cifra por si solo los datos que estan guardados

Evidencia, [04-tls.md](evidencias/04-tls.md)

## 5 Gestion de claves

Cree un archivo temporal con la clave de prueba escrita en la consulta, al leerlo tambien se podia ver la clave, despues lo borre como pide la practica

Una clave real no debe quedar junto con los scripts ni en el historial del repositorio, si alguien consigue esa clave y los datos cifrados podria recuperar la informacion

En un caso real se debe usar un gestor de secretos, limitar quien tiene acceso y tener un procedimiento para cambiar las claves o recuperarlas cuando sea necesario

Evidencias, [03-gestion-claves.md](evidencias/03-gestion-claves.md) y [10-politica-claves.md](evidencias/10-politica-claves.md)

## 6 Resultados

| Prueba | Resultado |
|---|---|
| Tabla insegura | La contrasena se ve directamente |
| Comparacion de hashes con sales nuevas | hashes_distintos fue true |
| Contrasenia correcta | true |
| Contrasenia incorrecta | false |
| RFC cifrado | Se mostro como datos binarios |
| Descifrado con clave correcta | Se recupero el RFC de prueba |
| Descifrado con otra clave | Wrong key or corrupt data |
| TLS al inicio | Apagado y sin TLS en la conexion |
| Nueva conexion con require | TLSv1.3 y TLS_AES_256_GCM_SHA384 |
| Sesion revisada de pgAdmin con ssl del servidor en on | false, sin TLS en esa sesion |
| Direccion y puerto del cliente de pgAdmin | 172.20.0.3 y 49366 |

Tambien compare que mecanismo corresponde a cada dato, revise el escenario de la empresa y propuse ocho reglas para cuidar las claves

Evidencias, [07-comparacion.md](evidencias/07-comparacion.md) y [08-analisis-escenario.md](evidencias/08-analisis-escenario.md)

### Revision antes del commit

Se revisaron los archivos buscando password, passwd, secret, token, api_key, clave y postgresql://

Lo que aparecio fueron nombres de campos y los ejemplos de la practica como Password123 y CLAVE-DE-PRUEBA, tambien el hash de prueba, no se encontraron claves ni contrasenas reales

El archivo temporal ya no esta y los archivos del certificado y la clave privada quedaron fuera de la entrega

Esta busqueda ayuda a revisar, pero tambien hay que leer los archivos y volver a revisar si se cambia algo

## 7 Problemas encontrados

Al principio TLS estaba apagado, para resolverlo se creo el certificado y se cambio la configuracion del servidor, despues fue necesario abrir una conexion nueva para comprobarlo

En psql si salio TLS y en pgAdmin siguio false, deje ambos resultados porque no todas las conexiones estaban usando lo mismo

Tambien aparecio relation clientes_protegidos does not exist porque intente consultar la tabla antes de crearla, despues ejecute primero la creacion y la insercion y ya pude continuar

El error con la clave incorrecta era parte de la prueba, no significaba que tuviera que borrar o crear otra vez la tabla

## 8 Conclusiones

Entendi que no todo se protege de la misma forma, para una contrasena necesito un hash, para un dato que debo recuperar necesito cifrado y para la conexion necesito TLS

Tambien hay que cuidar las claves, no sirve cifrar un dato si dejo la clave escrita donde cualquiera la puede copiar

En una empresa usaria un mecanismo de hash adecuado para contrasenas, TLS con validacion del servidor, permisos limitados, un gestor de secretos y respaldos cifrados con pruebas de recuperacion

## Preguntas de reflexion

### Por que una contrasena no debe almacenarse como texto claro

Porque quien pueda leer la tabla tambien podria verla y usarla para entrar a la cuenta

### Por que un hash no es equivalente a un cifrado

Porque el hash se usa para comprobar y no tiene un descifrado para recuperar la contrasena, el cifrado si permite recuperar el dato con la clave

### Por que cifrar una columna no sustituye al control de acceso

Porque tambien se debe decidir quien puede consultar los datos y quien puede descifrarlos, ademas otras columnas pueden seguir visibles

### Por que TLS no sustituye la autorizacion de PostgreSQL

Porque TLS protege la conexion pero no decide que tablas puede consultar o modificar cada usuario

### Que pasaria si se pierde una clave usada para cifrar informacion

Si no existe una copia recuperable podria perderse el acceso a los datos cifrados, aunque todavia se tenga el archivo o la tabla

### Que pasaria si una clave se publica accidentalmente en GitLab

Se debe considerar expuesta, avisar y cambiarla, tambien revisar los datos que protegia y volver a cifrarlos cuando corresponda, borrarla del archivo no la quita del historial

### Por que un repositorio privado no es un almacen de secretos

Porque tiene historial y pueden existir copias o personas con acceso, que sea privado no hace correcto guardar ahi una clave real

### Que diferencia hay entre proteger datos guardados y protegerlos durante su transmision

Una protege lo que esta en tablas, archivos o respaldos, la otra protege lo que viaja entre el cliente y el servidor

### Por que la gestion de claves es tan importante como el algoritmo

Porque si la clave se expone pueden descifrar los datos y si se pierde puede que ya no se puedan recuperar, aunque el algoritmo sea bueno

### Que mecanismo adicional usaria para proteger los respaldos

Los cifraria y limitaria el acceso, tambien guardaria la clave aparte y probaria que se puedan recuperar

## Archivos

Los scripts estan en sql y los resultados y respuestas en evidencias, se ejecutan en la base practicas con permisos de administrador y pgcrypto disponible

En 01 y 02 agregue condiciones para no volver a crear las tablas ni repetir los datos si ejecuto otra vez los archivos

En 02 la prueba con la clave incorrecta esta en un comentario y se ejecuta seleccionando solamente su SELECT, se espera un error y por eso se hace por separado

El archivo 03 revisa la configuracion y la conexion que estoy usando, para activar TLS primero hice los pasos que deje en evidencias/04-tls.md
