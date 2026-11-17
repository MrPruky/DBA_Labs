# Actividad 6. Cambio de configuracion


Estudiante: Osuna Rangel Diego Sebastian

Busque los cambios del perfilador y la autenticacion con el mismo ctx:

    let l=db.adminCommand({getLog:"global"}).log.map(x=>JSON.parse(x)); let cambios=l.filter(e=>e.msg==="Profiler settings changed"); print(EJSON.stringify(cambios.map(c=>({cambio:c,autenticacion:l.filter(e=>e.ctx===c.ctx&&e.msg==="Successfully authenticated")})),null,2))

Resultado:

    {
      "cambio": {
        "hora": {
          "$date": "2026-11-17T05:36:37.773+00:00"
        },
        "ctx": "conn26",
        "msg": "Profiler settings changed",
        "datos": {
          "from": {
            "level": 0,
            "slowms": 100,
            "sampleRate": 1
          },
          "to": {
            "level": 2,
            "slowms": 100,
            "sampleRate": 1
          },
          "db": "comercial"
        }
      },
      "autenticacion": {
        "hora": {
          "$date": "2026-11-17T05:36:23.207+00:00"
        },
        "ctx": "conn26",
        "usuario": "admin",
        "base": "admin",
        "cliente": "127.0.0.1:56636"
      }
    }

En esta conexion se autentico admin y despues cambio el perfilador. Hay que revisar los eventos del mismo arranque, porque los numeros de conexion se pueden repetir despues de reiniciar
