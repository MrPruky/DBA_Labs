# Actividad 7. Privilegios

Estudiante: Osuna Rangel Diego Sebastian

Comando:

    db.getSiblingDB("auditoria").instantaneas_privilegios.insertOne({momento:new Date(),tomada_por:db.runCommand({connectionStatus:1}).authInfo.authenticatedUsers,usuarios:db.getUsers().users.map(u=>({user:u.user,db:u.db,roles:u.roles}))}); print(EJSON.stringify(db.getSiblingDB("auditoria").instantaneas_privilegios.find({}, {_id:0}).toArray(),null,2))

Resultado:

    [
      {
        "momento": {
          "$date": "2026-11-17T05:50:04.366Z"
        },
        "tomada_por": [
          {
            "user": "admin",
            "db": "admin"
          }
        ],
        "usuarios": [
          {
            "user": "app_ventas",
            "db": "comercial",
            "roles": [
              {
                "role": "readWrite",
                "db": "comercial"
              }
            ]
          }
        ]
      }
    ]

Comando:

    db.setProfilingLevel(2); db.grantRolesToUser("app_ventas",[{role:"dbAdmin",db:"comercial"}]); print("rol otorgado")

Resultado:

    rol otorgado

Comando:

    print(EJSON.stringify({perfil:db.system.profile.countDocuments({"command.grantRolesToUser":{$exists:true}}),log:db.adminCommand({getLog:"global"}).log.filter(l=>l.includes("grantRoles")).length},null,2))

Resultado:

    {
      "perfil": 0,
      "log": 0
    }

Comando:

    db.getSiblingDB("auditoria").instantaneas_privilegios.insertOne({momento:new Date(),tomada_por:db.runCommand({connectionStatus:1}).authInfo.authenticatedUsers,usuarios:db.getUsers().users.map(u=>({user:u.user,db:u.db,roles:u.roles}))}); print(EJSON.stringify(db.getSiblingDB("auditoria").instantaneas_privilegios.find({}, {_id:0}).sort({momento:1}).toArray(),null,2))

Resultado:

    [
      {
        "momento": {
          "$date": "2026-11-17T05:50:04.366Z"
        },
        "tomada_por": [
          {
            "user": "admin",
            "db": "admin"
          }
        ],
        "usuarios": [
          {
            "user": "app_ventas",
            "db": "comercial",
            "roles": [
              {
                "role": "readWrite",
                "db": "comercial"
              }
            ]
          }
        ]
      },
      {
        "momento": {
          "$date": "2026-11-17T05:54:36.424Z"
        },
        "tomada_por": [
          {
            "user": "admin",
            "db": "admin"
          }
        ],
        "usuarios": [
          {
            "user": "app_ventas",
            "db": "comercial",
            "roles": [
              {
                "role": "readWrite",
                "db": "comercial"
              },
              {
                "role": "dbAdmin",
                "db": "comercial"
              }
            ]
          }
        ]
      }
    ]

Comando:

    db.revokeRolesFromUser("app_ventas",[{role:"dbAdmin",db:"comercial"}]); db.setProfilingLevel(1,{filter:{op:{$in:["insert","update","remove"]}}}); print(EJSON.stringify(db.getProfilingStatus(),null,2))

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

La primera copia muestra readWrite y la segunda tambien muestra dbAdmin. La busqueda del cambio en perfilador y bitacora dio 0. Las copias dejan ver que hubo un cambio, pero no quien lo hizo ni la hora exacta. Despues quite dbAdmin

Las copias deberian quedar en un lugar con escritura limitada. Las revisaria con frecuencia segun el riesgo; por ejemplo, una vez al dia y antes y despues de cambios autorizados
