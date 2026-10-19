# 07 Proteccion en reposo y en transito

OSUNA RANGEL DIEGO SEBASTIAN

## Objetivo

Identificar que mecanismo sirve para proteger cada tipo de informacion

## Comando o procedimiento

Compare las situaciones de la practica y complete la tabla segun si la informacion esta guardada, se esta enviando o es una credencial

## Resultado obtenido

| Situacion | Mecanismo apropiado | Que protege |
|---|---|---|
| Contrasenia de usuario | Hash para contrasenas con sal y un algoritmo adecuado | Evita guardar la contrasena directamente y permite comprobarla |
| RFC almacenado en una tabla | Cifrado y permisos limitados | Protege el contenido del RFC guardado y permite recuperarlo con la clave cuando se autoriza |
| Consulta enviada desde un cliente al servidor | TLS con validacion del servidor | Protege la comunicacion y permite comprobar con quien se establece |
| Respaldo de una base de datos | Cifrado del respaldo y control de acceso | Protege la informacion si alguien obtiene el archivo del respaldo |
| Clave criptografica | Gestion de secretos y acceso limitado | Protege la clave y controla quien puede usarla |

## Analisis

Para la contrasena use un hash porque solo necesito comprobarla, para el RFC use cifrado porque si necesito recuperarlo, TLS protege lo que viaja por la conexion

## Conclusion

Entendi que cuidar los datos guardados no es lo mismo que cuidar la conexion, tambien se debe proteger la clave
