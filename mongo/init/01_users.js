
const dbName = 'uapaSoftwareLibreDB';
const appDb = db.getSiblingDB(dbName);

appDb.createUser({
  user: "someadminuser",
  pwd: "somepass",
  roles: [ { role: "dbOwner", db: dbName } ]
});

["user1","user2"].forEach(u => {
  appDb.createUser({
    user: u,
    pwd: `${u}password123`,
    roles: [ { role: "readWrite", db: dbName } ]
  });
});
