# LAB-01 - Proteccion y privacidad de datos

OSUNA RANGEL DIEGO SEBASTIAN

Gestion de Seguridad y Desempeno de Bases de Datos

## Objetivo

Proteger los datos de los clientes dependiendo de quien los necesita consultar, para esto use PostgreSQL y pgAdmin

## 1 Clasificacion de los datos

Primero cree la tabla clientes e inserte los cinco clientes de prueba, despues revise que datos tenia la tabla y cuales podian servir para identificar a alguien

| Campo | Identifica directamente | Puede contribuir a identificar | Requiere proteccion | Justificacion |
|---|---|---|---|---|
| id | No por si solo | Si | Si | Sirve para buscar al cliente y relacionarlo con otras tablas |
| nombre | Si, segun el contexto | Si | Si | Permite reconocer al cliente, aunque puede haber nombres iguales |
| correo | Si, segun el contexto | Si | Si | Puede relacionarse con una persona y sirve para contactarla |
| telefono | Si, segun el contexto | Si | Si | Puede relacionarse con su titular y sirve para contactarlo |
| rfc | Si | Si | Si | Es un identificador fiscal del cliente |
| edad | No por si sola | Si | Si | Junto con la ubicacion puede ayudar a identificar a alguien |
| ciudad | No por si sola | Si | Si | Ayuda a saber en que lugar esta la persona |
| codigo_postal | No por si solo | Si | Si | Da una ubicacion mas especifica y puede combinarse con la edad |
| fecha_alta | No por si sola | Si | Si | Puede compararse con otras fechas que se conozcan del cliente |

El nombre y el RFC permiten identificar al cliente, el correo y el telefono tambien pueden relacionarse con una persona segun el caso

La edad y el codigo postal por separado no dicen quien es alguien, pero juntos pueden ayudar a identificarlo, por eso tambien necesitan proteccion

No todos estos datos son automaticamente datos personales sensibles desde el punto de vista juridico, aun asi se deben proteger para cuidar la privacidad y evitar que se usen para perjudicar a la persona


## 2 Enmascaramiento

Aqui cree el rol soporte y la vista v_clientes_soporte, la vista muestra el id y el nombre completos, pero oculta una parte del correo, telefono y RFC con asteriscos

En el correo deje las primeras dos letras y el dominio, en el telefono y el RFC deje los ultimos cuatro caracteres

Despues le di a soporte permiso para usar el esquema public y consultar la vista, tambien le quite los permisos sobre clientes

Para probarlo use SET ROLE soporte, porque con mi usuario administrador podia seguir viendo la tabla original, al usar soporte si pude consultar la vista y al consultar clientes aparecio permission denied for table clientes

Toda la informacion sigue en la tabla original, solo se crea una vista para mostrarla de otra forma, si soporte tuviera acceso directo a clientes podria ver todo completo y la informacion del cliente quedaria expuesta

Por eso no basta con ocultar los datos en la aplicacion, tambien se deben limitar los permisos en la base de datos

## 3 Seudonimizacion

Primero cree los esquemas pii y analitica, despues cree pii.mapa_cliente con las columnas token y cliente_id

Use gen_random_uuid para generar un token para cada cliente, el mapa guarda que token le corresponde a cada id

Despues cree analitica.clientes usando el mapa y la tabla clientes, esta tabla tiene el token, edad, ciudad, codigo postal y fecha de alta, ya no tiene el nombre, correo, telefono ni RFC

Tambien cree el rol analista y le di permiso para consultar analitica.clientes, las capturas muestran esa consulta permitida y los errores al intentar consultar pii.mapa_cliente y public.clientes

El mapa debe quedar para el administrador o para quien tenga autorizacion, si el analista pudiera verlo podria relacionar los tokens con los id originales, si tambien obtiene los datos originales podria saber de quien son

Aqui se aplica el minimo privilegio y la separacion de funciones, el analista solo debe tener lo que necesita para trabajar

Esto no es lo mismo que anonimizar, porque todavia existe un mapa que une el token con el cliente, tambien quedan datos como la edad y la ubicacion que pueden ayudar a identificarlo
## 4 Anonimizacion

En esta parte use consultas para mostrar cantidades de clientes, sin mostrar sus nombres ni sus datos completos, esta informacion es para direccion

Primero agrupe por rangos de edad, salieron cuatro clientes de 31 a 45 y uno de 46 o mas

Despues use los primeros dos numeros del codigo postal para agrupar por region, salieron tres clientes en la region 80, uno en la 81 y uno en la 82

Al juntar el rango de edad con la region salio lo siguiente

| Rango de edad | Region | Total |
|---|---|---|
| 31-45 | 80 | 3 |
| 31-45 | 81 | 1 |
| 46+ | 82 | 1 |

Despues agregue HAVING COUNT(*) >= 5 y no salieron registros, esto paso porque ningun grupo tenia cinco clientes, no se borraron datos de la tabla, solo dejaron de aparecer esos grupos en el resultado

Ya no se muestran el id, nombre, correo, telefono ni RFC, pero el rango de edad y la region todavia pueden ayudar a identificar a alguien si se combinan con otra informacion

Cuando hay pocos registros en un grupo es mas facil distinguir a las personas, por eso se pueden usar rangos mas amplios y dejar fuera los grupos pequenos

### Reto

Quite el rango de edad y deje solamente el primer numero del codigo postal

```sql
SELECT
    LEFT(codigo_postal, 1) AS region,
    COUNT(*) AS total
FROM clientes
GROUP BY 1
HAVING COUNT(*) >= 5;
```

Cambio realizado, quite la edad de la agrupacion y use un numero del codigo postal en lugar de dos

Motivo, juntar mas clientes en un mismo grupo y mostrar menos detalles

Resultado obtenido, salio un grupo con region 8 y un total de 5 clientes

Riesgo que se pretende reducir, que se pueda identificar a una persona por su rango de edad y su region postal

Asi ya no puedo comparar los grupos por edad, pero muestro menos informacion de los clientes, aun con cinco registros no se puede decir que sea cien por ciento anonimo porque alguien podria combinarlo con otros datos


## 5 Retencion

Aqui use la consulta de la practica para buscar clientes registrados hace mas de cinco anios

```sql
SELECT *
FROM clientes
WHERE fecha_alta <
      CURRENT_DATE - INTERVAL '5 years';
```

No salieron registros, los clientes de esta practica no superaban ese tiempo, solamente hice la consulta y no borre informacion

Los cinco anios son un ejemplo de la practica, en una empresa se tendria que revisar para que se necesitan los datos y que obligaciones existen antes de decidir cuanto tiempo guardarlos

Se deberia conservar la informacion que todavia sea necesaria, la que ya cumplio su tiempo y no se necesite podria eliminarse con autorizacion

Antes de borrar se necesita la aprobacion del responsable y un respaldo protegido que se pueda recuperar, tambien se debe revisar si los datos siguen en el mapa o en la tabla de analitica

Como evidencia se deberia guardar quien autorizo, quien hizo el proceso, la fecha, el criterio y cuantos registros fueron afectados

Si se borra algo por error se puede restaurar el respaldo en una base aparte, revisar los registros y recuperar lo que haga falta


## 6 Verificacion final

| Prueba | Resultado |
|---|---|
| Soporte consulta la vista | Se ven los datos parcialmente ocultos |
| Soporte consulta clientes | Aparece error de permiso |
| Consulta a analitica.clientes | Se ven cinco registros con sus tokens |
| Consulta restringida al mapa | Aparece error de permiso en pii |
| Consulta restringida a public.clientes | Aparece error de permiso |
| Consultas para direccion | Se ven cantidades y grupos, sin nombres de clientes |
| Consulta de retencion | No aparecen registros con mas de cinco anios |

Para comprobar los permisos se debe usar el rol que corresponde, como administrador si se pueden ver los originales y eso no sirve para comprobar las restricciones de soporte o analista

## 7 Conclusiones

### Que tecnica utilizaria para soporte

Una vista con enmascaramiento, para que soporte vea lo que necesita sin tener todos los datos completos

### Que tecnica utilizaria para analitica

La seudonimizacion, usando tokens y sin darle al analista acceso al mapa

### Que tecnica utilizaria para publicar estadisticas

Agruparia los datos y quitaria los grupos pequenos, tambien revisaria que la informacion no permita identificar a alguien

### Por que estas tecnicas no sustituyen al control de acceso

Porque los datos originales siguen existiendo, si alguien tiene permiso para verlos puede consultar la informacion completa

Lo que entendi es que no todas las areas necesitan ver lo mismo, ocultar un dato no lo borra y ponerle un token tampoco significa que ya sea anonimo

## 8 Preguntas de reflexion

### Cual es la diferencia entre enmascaramiento y seudonimizacion

El enmascaramiento oculta parte de lo que se muestra, la seudonimizacion usa un token para representar al cliente y guarda la relacion en un mapa

### Por que la seudonimizacion no significa anonimizacion

Porque todavia existe el mapa que permite relacionar los datos con el cliente

### Por que eliminar nombre y RFC no garantiza que un conjunto sea anonimo

Porque con la edad y la ubicacion tambien se podria identificar a alguien al combinar esa informacion con otros datos

### Que funcion tienen los cuasi-identificadores

Son datos que solos pueden no decir quien es alguien, pero juntos pueden ayudar a identificarlo

### Por que es importante separar el mapa de seudonimizacion

Porque el mapa une el token con el id del cliente, si el analista lo puede consultar tendria mas facilidad para relacionarlos

### Que principio se aplica al impedir que el analista acceda al mapa

El minimo privilegio y la separacion de funciones, darle solamente el acceso que necesita

### Por que una vista puede ser preferible a dar acceso directo a la tabla

Porque en la vista se puede elegir que informacion mostrar, en la tabla original estan los datos completos

### Que diferencia hay entre proteger un dato para visualizacion y protegerlo contra acceso no autorizado

Una cosa es ocultar lo que se muestra y otra es impedir que alguien entre a consultar los datos, si no se limitan los permisos podria verlos de otra forma

### Por que la retencion forma parte de la proteccion de datos

Porque ayuda a no guardar informacion que ya no se necesita y a decidir durante cuanto tiempo conservarla

### Que riesgo existe si se guarda informacion indefinidamente

Se juntan datos que tal vez ya no sirven y si se filtran podria exponerse informacion de mas personas
