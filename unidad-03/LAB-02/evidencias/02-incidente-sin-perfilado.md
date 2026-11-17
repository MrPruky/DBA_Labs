# Actividad 2. Cambio sin perfilado


Estudiante: Osuna Rangel Diego Sebastian

Comando:

    print(EJSON.stringify(db.getProfilingStatus(),null,2))

Resultado:

    {
      "was": 0,
      "slowms": 100,
      "sampleRate": 1,
      "ok": 1
    }

Comando:

    print(EJSON.stringify(db.clientes.updateOne({_id:3},{$set:{rfc:"GAMA780912XXX"}}),null,2))

Resultado:

    {
      "acknowledged": true,
      "insertedId": null,
      "matchedCount": 1,
      "modifiedCount": 1,
      "upsertedCount": 0
    }

Comando:

    print(EJSON.stringify({perfil:db.getCollectionNames().includes("system.profile")?db.system.profile.countDocuments():0,log:db.adminCommand({getLog:"global"}).log.filter(l=>l.includes("GAMA780912XXX")).length},null,2))

Resultado:

    {
      "perfil": 0,
      "log": 0
    }

El perfilador estaba en 0. Se cambio el RFC, pero no aparecio en el perfilador ni en la bitacora. Con esos registros no puedo demostrar quien lo cambio o a que hora
