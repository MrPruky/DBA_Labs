# Actividad 4. Filtro del perfilador

Estudiante: Osuna Rangel Diego Sebastian

Comando:

    db.setProfilingLevel(0); db.system.profile.drop(); db.setProfilingLevel(1,{filter:{op:{$in:["insert","update","remove"]}}}); print(EJSON.stringify(db.getProfilingStatus(),null,2))

Resultado:

    {
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
    }

Comando:

    print(EJSON.stringify({consulta:db.clientes.find({_id:1}).toArray(),cambio:db.clientes.updateOne({_id:1},{$set:{telefono:"6670000000"}})},null,2))

Resultado:

    {
      "consulta": [
        {
          "_id": 1,
          "nombre": "Ana López",
          "correo": "ana.lopez@example.test",
          "telefono": "6671234567",
          "rfc": "LOAA850315ABC",
          "edad": 41,
          "ciudad": "Culiacán",
          "codigo_postal": "80000"
        }
      ],
      "cambio": {
        "acknowledged": true,
        "insertedId": null,
        "matchedCount": 1,
        "modifiedCount": 1,
        "upsertedCount": 0
      }
    }

Comando:

    print(EJSON.stringify(db.system.profile.find({},{op:1,ns:1,user:1,appName:1,"command.q":1,"command.u":1,ts:1}).toArray(),null,2))

Resultado:

    [
      {
        "op": "update",
        "ns": "comercial.clientes",
        "command": {
          "q": {
            "_id": 1
          },
          "u": {
            "$set": {
              "telefono": "6670000000"
            }
          }
        },
        "ts": {
          "$date": "2026-11-17T05:42:03.304Z"
        },
        "appName": "app-ventas-web",
        "user": "app_ventas@comercial"
      }
    ]

Puse un filtro para insert, update y remove. La lectura se hizo pero no salio en el perfilador. El cambio de telefono si aparecio. Asi se guardan menos cosas, pero ya no se pueden ver esas consultas
