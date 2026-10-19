# 08 Analisis de un escenario de seguridad

OSUNA RANGEL DIEGO SEBASTIAN

## Objetivo

Ver que problemas tiene la empresa del ejemplo aunque ya tenga usuarios y permisos

## Comando o procedimiento

Revise el caso de la practica, las contrasenas y el RFC estan en texto claro, no se valida bien al servidor, las claves estan en archivos SQL y los respaldos no tienen proteccion adicional

## Resultado obtenido

### Cuales son los principales riesgos

Que alguien lea las contrasenas y entre a las cuentas, que vea el RFC y la informacion financiera, que se conecten a un servidor que no sea el correcto y que usen las claves publicadas para descifrar los datos, tambien se puede exponer toda la informacion si alguien consigue un respaldo

### Que mecanismo utilizaria para cada elemento

| Elemento | Que utilizaria |
|---|---|
| Nombre y correo | Permisos limitados y mostrar solo lo necesario, revisar si tambien necesitan cifrado segun su uso |
| Contrasenia | Hash para contrasenas con sal |
| RFC | Cifrado y acceso limitado al descifrado |
| Informacion financiera | Cifrado y permisos segun el trabajo de cada usuario |
| Claves criptograficas | Un gestor de secretos y acceso solamente para quien lo necesita |
| Conexion | TLS con verify-full y un certificado confiable que coincida con el servidor |
| Respaldos | Cifrado, acceso limitado y pruebas de recuperacion |

### Cual problema considero mas critico y por que

Las contrasenas en texto claro porque se pueden usar directamente si alguien las obtiene, las claves en los archivos SQL tambien son graves porque permiten descifrar la informacion que protegen

### Tener bien configurados los usuarios y permisos elimina estos riesgos

No, los permisos no cambian como se guardan las contrasenas ni cifran los respaldos, tampoco hacen que la conexion valide al servidor o que una clave publicada deje de estar expuesta

## Analisis

Los permisos ayudan pero no arreglan todo, tambien hay que cuidar las contrasenas, la conexion, las claves y los respaldos

## Conclusion

Primero quitaria las contrasenas en texto claro y las claves de los scripts, tambien protegeria los datos y respaldos y revisaria que las conexiones validen al servidor
