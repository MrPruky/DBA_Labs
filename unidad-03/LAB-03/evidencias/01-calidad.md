# Actividad 1. Calidad de datos

Agregue los dos registros de prueba y ejecute las verificaciones de sql/01-verificaciones-calidad.sql

Resultado:

    INSERT 0 2
       correo_normalizado   | registros | ids  
    ------------------------+-----------+------
     ana.lopez@example.test |         2 | 1, 7
    (1 row)
    
     id |   nombre   |     rfc      
    ----+------------+--------------
      7 | Ana Lopez  | LOAA850315AB
      8 | Jorge Díaz | 
    (2 rows)
    
     id |   nombre   |   correo   
    ----+------------+------------
      8 | Jorge Díaz | sin-correo
    (1 row)
    
     id |   nombre   | edad 
    ----+------------+------
      8 | Jorge Díaz |   -3
    (1 row)
    
     total | sin_telefono | sin_rfc 
    -------+--------------+---------
         7 |            0 |       1
    (1 row)

Hallazgos:

    Hallazgo	Registros	Regla	Quien decide	Que hacer
    Correo repetido	1 y 7	Unicidad	Atencion y Gerencia Comercial	Revisar si son la misma persona
    RFC incompleto	7	Formato	Facturacion	Consultar el dato correcto
    RFC faltante	8	Completitud	Facturacion	Solicitar el RFC si hace falta
    Correo incorrecto	8	Formato	Atencion	Confirmar el correo
    Edad negativa	8	Rango	Gerencia Comercial	Confirmar y corregir

El telefono y codigo postal del registro 8 tambien necesitan revision, pero estas consultas no revisaron su formato. La prueba del RFC solo revisa el formato, no dice si existe

El DBA no debe inventar el RFC correcto, primero debe confirmarlo el area responsable. Para evitar errores se puede revisar el uso de UNIQUE para correo y CHECK para formatos y edad, despues de corregir los datos y pedir aprobacion. El disparador del LAB-01 guarda cambios en clientes. No borre los registros de prueba
