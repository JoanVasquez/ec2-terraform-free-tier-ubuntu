
const dbName = 'uapaSoftwareLibreDB';
const appDb = db.getSiblingDB(dbName);

appDb.createUser({
  user: "ubuntu",
  pwd: "ubuntupass123",
  roles: [ { role: "dbOwner", db: dbName } ]
});

// Usuarios con readWrite
["david","frank","joanv","joel","josec","sarai"].forEach(u => {
  appDb.createUser({
    user: u,
    pwd: `${u}pass123`,
    roles: [ { role: "readWrite", db: dbName } ]
  });
});
