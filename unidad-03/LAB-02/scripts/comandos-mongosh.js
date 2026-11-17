// Ejecutar por partes en la base comercial; reemplaza <REDACTED> por una contraseña de practica.
// preparacion
db.createUser({user:"app_ventas",pwd:"<REDACTED>",roles:[{role:"readWrite",db:"comercial"}]});
db.clientes.insertMany([
{_id:1,nombre:"Ana López",correo:"ana.lopez@example.test",telefono:"6671234567",rfc:"LOAA850315ABC",edad:41,ciudad:"Culiacán",codigo_postal:"80000"},
{_id:2,nombre:"Carlos Pérez",correo:"carlos.perez@example.test",telefono:"6672345678",rfc:"PECA900720DEF",edad:35,ciudad:"Culiacán",codigo_postal:"80100"},
{_id:3,nombre:"María García",correo:"maria.garcia@example.test",telefono:"6673456789",rfc:"GAMA780912GHI",edad:47,ciudad:"Mazatlán",codigo_postal:"82000"},
{_id:4,nombre:"Luis Torres",correo:"luis.torres@example.test",telefono:"6674567890",rfc:"TOLU920201JKL",edad:34,ciudad:"Los Mochis",codigo_postal:"81200"},
{_id:5,nombre:"Laura Sánchez",correo:"laura.sanchez@example.test",telefono:"6675678901",rfc:"SALA880525MNO",edad:38,ciudad:"Culiacán",codigo_postal:"80200"}]); print('usuarios y datos creados')

// 01_edicion
print(EJSON.stringify({version:db.version(),modules:db.adminCommand({buildInfo:1}).modules,configuracion:db.serverCmdLineOpts().parsed},null,2))

// 02_estado_inicial
print(EJSON.stringify(db.getProfilingStatus(),null,2))

// 02_cambio_sin_perfilado
print(EJSON.stringify(db.clientes.updateOne({_id:3},{$set:{rfc:"GAMA780912XXX"}}),null,2))

// 02_busqueda
print(EJSON.stringify({perfil:db.getCollectionNames().includes("system.profile")?db.system.profile.countDocuments():0,log:db.adminCommand({getLog:"global"}).log.filter(l=>l.includes("GAMA780912XXX")).length},null,2))

// 03_activar
print(EJSON.stringify({antes:db.setProfilingLevel(2),actual:db.getProfilingStatus()},null,2))

// 03_operaciones
print(EJSON.stringify({consulta:db.clientes.find({ciudad:"Culiacán"},{nombre:1,ciudad:1}).toArray(),cambio:db.clientes.updateOne({_id:3},{$set:{rfc:"GAMA780912XYZ"}}),borrado:db.clientes.deleteOne({_id:2})},null,2))

// 03_perfil
print(EJSON.stringify(db.system.profile.find({ns:"comercial.clientes"},{op:1,ns:1,command:1,user:1,client:1,appName:1,ts:1,millis:1,nreturned:1,docsExamined:1,nModified:1,ndeleted:1}).sort({ts:1}).toArray(),null,2))

// 04_filtro
db.setProfilingLevel(0); db.system.profile.drop(); db.setProfilingLevel(1,{filter:{op:{$in:["insert","update","remove"]}}}); print(EJSON.stringify(db.getProfilingStatus(),null,2))

// 04_operaciones
print(EJSON.stringify({consulta:db.clientes.find({_id:1}).toArray(),cambio:db.clientes.updateOne({_id:1},{$set:{telefono:"6670000000"}})},null,2))

// 04_perfil
print(EJSON.stringify(db.system.profile.find({},{op:1,ns:1,user:1,appName:1,"command.q":1,"command.u":1,ts:1}).toArray(),null,2))

// 05_accesos
let l=db.adminCommand({getLog:"global"}).log.map(x=>JSON.parse(x)); print(EJSON.stringify(l.filter(e=>e.c==="ACCESS" && ["Failed to authenticate","Successfully authenticated"].includes(e.msg) && ["app_ventas","usuario_inexistente"].includes(e.attr?.user)).map(e=>({t:e.t,ctx:e.ctx,msg:e.msg,user:e.attr.user,client:e.attr.client,result:e.attr.result,error:e.attr.error,app:e.attr.doc?.application?.name})),null,2))

// 06_correlacion
let l=db.adminCommand({getLog:"global"}).log.map(x=>JSON.parse(x)); let cambios=l.filter(e=>e.msg==="Profiler settings changed"); print(EJSON.stringify(cambios.map(c=>({cambio:c,autenticacion:l.filter(e=>e.ctx===c.ctx&&e.msg==="Successfully authenticated")})),null,2))

// 07_antes
db.getSiblingDB("auditoria").instantaneas_privilegios.insertOne({momento:new Date(),tomada_por:db.runCommand({connectionStatus:1}).authInfo.authenticatedUsers,usuarios:db.getUsers().users.map(u=>({user:u.user,db:u.db,roles:u.roles}))}); print(EJSON.stringify(db.getSiblingDB("auditoria").instantaneas_privilegios.find({}, {_id:0}).toArray(),null,2))

// 07_grant
db.setProfilingLevel(2); db.grantRolesToUser("app_ventas",[{role:"dbAdmin",db:"comercial"}]); print("rol otorgado")

// 07_busqueda
print(EJSON.stringify({perfil:db.system.profile.countDocuments({"command.grantRolesToUser":{$exists:true}}),log:db.adminCommand({getLog:"global"}).log.filter(l=>l.includes("grantRoles")).length},null,2))

// 07_despues
db.getSiblingDB("auditoria").instantaneas_privilegios.insertOne({momento:new Date(),tomada_por:db.runCommand({connectionStatus:1}).authInfo.authenticatedUsers,usuarios:db.getUsers().users.map(u=>({user:u.user,db:u.db,roles:u.roles}))}); print(EJSON.stringify(db.getSiblingDB("auditoria").instantaneas_privilegios.find({}, {_id:0}).sort({momento:1}).toArray(),null,2))

// 07_restablecer
db.revokeRolesFromUser("app_ventas",[{role:"dbAdmin",db:"comercial"}]); db.setProfilingLevel(1,{filter:{op:{$in:["insert","update","remove"]}}}); print(EJSON.stringify(db.getProfilingStatus(),null,2))

// 08_exportar_perfil
print(EJSON.stringify(db.system.profile.find({},{op:1,ns:1,user:1,client:1,appName:1,ts:1,"command.q":1,"command.u":1}).toArray(),null,2))

// 08_antes_reinicio
print(EJSON.stringify({perfil:db.getProfilingStatus(),registros:db.system.profile.countDocuments(),lineas:db.adminCommand({getLog:"global"}).log.length},null,2))

// 08_exportar_bitacora
print(db.adminCommand({getLog:"global"}).log.join("\n"))

// 08_despues_reinicio
print(EJSON.stringify({perfil:db.getProfilingStatus(),registros:db.system.profile.countDocuments(),lineas:db.adminCommand({getLog:"global"}).log.length},null,2))
