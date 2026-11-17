# Actividad 1. Edicion de MongoDB
Estudiante: Osuna Rangel Diego Sebastian

Comando:

    print(EJSON.stringify({version:db.version(),modules:db.adminCommand({buildInfo:1}).modules,configuracion:db.serverCmdLineOpts().parsed},null,2))

Resultado:

    {
      "version": "7.0.48",
      "modules": [],
      "configuracion": {
        "net": {
          "bindIp": "*"
        },
        "security": {
          "authorization": "enabled"
        }
      }
    }

Use MongoDB 7.0.48 Community en Docker con autorizacion. modules salio vacio. Esta version no tiene auditoria nativa. El perfilador y la bitacora ayudan a revisar lo que paso, pero no hacen lo mismo

El servidor envia la bitacora a la salida del contenedor. Con getLog tambien pude consultar las lineas recientes
