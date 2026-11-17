# Actividad 5. Accesos

Estudiante: Osuna Rangel Diego Sebastian

Prueba:

    intento de acceso con app_ventas

Resultado:

    MongoServerError: Authentication failed.

Prueba:

    intento de acceso con usuario_inexistente

Resultado:

    MongoServerError: Authentication failed.

Resultado de getLog:

    [
      {
        "t": {
          "$date": "2026-11-17T05:44:27.300+00:00"
        },
        "ctx": "conn50",
        "msg": "Failed to authenticate",
        "user": "app_ventas",
        "client": "127.0.0.1:56848",
        "result": 18,
        "error": "AuthenticationFailed: SCRAM authentication failed, storedKey mismatch",
        "app": "mongosh 2.14.2"
      },
      {
        "t": {
          "$date": "2026-11-17T05:45:41.497+00:00"
        },
        "ctx": "conn52",
        "msg": "Failed to authenticate",
        "user": "usuario_inexistente",
        "client": "127.0.0.1:56868",
        "result": 11,
        "error": "UserNotFound: Could not find user \"usuario_inexistente\" for db \"comercial\"",
        "app": "mongosh 2.14.2"
      },
      {
        "t": {
          "$date": "2026-11-17T05:45:41.693+00:00"
        },
        "ctx": "conn52",
        "msg": "Failed to authenticate",
        "user": "usuario_inexistente",
        "client": "127.0.0.1:56868",
        "result": 11,
        "error": "UserNotFound: Could not find user \"usuario_inexistente\" for db \"comercial\"",
        "app": "mongosh 2.14.2"
      },
      {
        "t": {
          "$date": "2026-11-17T05:42:03.304+00:00"
        },
        "ctx": "conn44",
        "msg": "Successfully authenticated",
        "user": "app_ventas",
        "client": "127.0.0.1:56790",
        "result": 0,
        "error": null,
        "app": "app-ventas-web"
      }
    ]

Los intentos fallidos muestran Failed to authenticate y el acceso correcto Successfully authenticated. El servidor distingue contraseña incorrecta de usuario inexistente, aunque el cliente recibe Authentication failed. Puede haber mas de una linea para un mismo intento
