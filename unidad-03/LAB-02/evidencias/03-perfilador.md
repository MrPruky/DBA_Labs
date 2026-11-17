# Actividad 3. Perfilador


Estudiante: Osuna Rangel Diego Sebastian

Comando:

    print(EJSON.stringify({antes:db.setProfilingLevel(2),actual:db.getProfilingStatus()},null,2))

Resultado:

    {
      "antes": {
        "was": 0,
        "slowms": 100,
        "sampleRate": 1,
        "ok": 1
      },
      "actual": {
        "was": 2,
        "slowms": 100,
        "sampleRate": 1,
        "ok": 1
      }
    }

Comando:

    print(EJSON.stringify({consulta:db.clientes.find({ciudad:"Culiacán"},{nombre:1,ciudad:1}).toArray(),cambio:db.clientes.updateOne({_id:3},{$set:{rfc:"GAMA780912XYZ"}}),borrado:db.clientes.deleteOne({_id:2})},null,2))

Resultado:

    {
      "consulta": [
        {
          "_id": 1,
          "nombre": "Ana López",
          "ciudad": "Culiacán"
        },
        {
          "_id": 2,
          "nombre": "Carlos Pérez",
          "ciudad": "Culiacán"
        },
        {
          "_id": 5,
          "nombre": "Laura Sánchez",
          "ciudad": "Culiacán"
        }
      ],
      "cambio": {
        "acknowledged": true,
        "insertedId": null,
        "matchedCount": 1,
        "modifiedCount": 1,
        "upsertedCount": 0
      },
      "borrado": {
        "acknowledged": true,
        "deletedCount": 1
      }
    }

Comando:

    print(EJSON.stringify(db.system.profile.find({ns:"comercial.clientes"},{op:1,ns:1,command:1,user:1,client:1,appName:1,ts:1,millis:1,nreturned:1,docsExamined:1,nModified:1,ndeleted:1}).sort({ts:1}).toArray(),null,2))

Resultado:

    [
      {
        "op": "query",
        "ns": "comercial.clientes",
        "command": {
          "find": "clientes",
          "filter": {
            "ciudad": "Culiacán"
          },
          "projection": {
            "nombre": 1,
            "ciudad": 1
          },
          "lsid": {
            "id": {
              "$binary": {
                "base64": "o67OEOADT2GJQ2Xh01o5tw==",
                "subType": "04"
              }
            }
          },
          "$db": "comercial"
        },
        "docsExamined": 5,
        "nreturned": 3,
        "millis": 0,
        "ts": {
          "$date": "2026-11-17T05:38:01.355Z"
        },
        "client": "127.0.0.1",
        "appName": "app-ventas-web",
        "user": "app_ventas@comercial"
      },
      {
        "op": "update",
        "ns": "comercial.clientes",
        "command": {
          "q": {
            "_id": 3
          },
          "u": {
            "$set": {
              "rfc": "GAMA780912XYZ"
            }
          },
          "multi": false,
          "upsert": false
        },
        "docsExamined": 1,
        "nModified": 1,
        "millis": 0,
        "ts": {
          "$date": "2026-11-17T05:38:01.844Z"
        },
        "client": "127.0.0.1",
        "appName": "app-ventas-web",
        "user": "app_ventas@comercial"
      },
      {
        "op": "remove",
        "ns": "comercial.clientes",
        "command": {
          "q": {
            "_id": 2
          },
          "limit": 1
        },
        "docsExamined": 1,
        "ndeleted": 1,
        "millis": 0,
        "ts": {
          "$date": "2026-11-17T05:38:03.115Z"
        },
        "client": "127.0.0.1",
        "appName": "app-ventas-web",
        "user": "app_ventas@comercial"
      }
    ]

Con nivel 2 aparecieron query, update y remove. En los tres pude ver la operacion, usuario, cliente, aplicacion y hora. El update guarda el valor nuevo, no una copia del anterior. Los registros usan UTC
