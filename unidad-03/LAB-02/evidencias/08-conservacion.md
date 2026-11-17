# Actividad 8. Guardar los registros

Estudiante: Osuna Rangel Diego Sebastian

Comando:

    print(EJSON.stringify({perfil:db.getProfilingStatus(),registros:db.system.profile.countDocuments(),lineas:db.adminCommand({getLog:"global"}).log.length},null,2))

Resultado:

    {
      "perfil": {
        "was": 1,
        "slowms": 100,
        "sampleRate": 1,
        "filter": {
          "op": {
            "$in": [
              "insert",
              "remove",
              "update"
            ]
          }
        },
        "note": "When a filter expression is set, slowms and sampleRate are not used for profiling and slow-query log lines.",
        "ok": 1
      },
      "registros": 2,
      "lineas": 534
    }

Comando:

    print(EJSON.stringify({perfil:db.getProfilingStatus(),registros:db.system.profile.countDocuments(),lineas:db.adminCommand({getLog:"global"}).log.length},null,2))

Resultado:

    {
      "perfil": {
        "was": 0,
        "slowms": 100,
        "sampleRate": 1,
        "ok": 1
      },
      "registros": 2,
      "lineas": 77
    }

Antes de reiniciar exporte system.profile y la bitacora de getLog y calcule SHA-256 para cada archivo. Despues del reinicio el nivel volvio a 0, los dos documentos seguian y getLog tenia menos lineas

Los registros se pueden perder al reiniciar, al llenarse la coleccion o por la rotacion de los logs. getLog guarda solo eventos recientes en memoria, por eso hace falta exportarlos y guardar una copia aparte
