(function () {
  const dbname = process.env.MONGO_INITDB_DATABASE || "uapaSoftwareLibreDB";
  const users = [
    {
      u: "ubuntu",
      p: "ubuntupass123",
      roles: [{ role: "dbOwner", db: dbname }],
    },
    {
      u: "david",
      p: "davidpass123",
      roles: [{ role: "readWrite", db: dbname }],
    },
    {
      u: "frank",
      p: "frankpass123",
      roles: [{ role: "readWrite", db: dbname }],
    },
    {
      u: "joanv",
      p: "joanvpass123",
      roles: [{ role: "readWrite", db: dbname }],
    },
    { u: "joel", p: "joelpass123", roles: [{ role: "readWrite", db: dbname }] },
    {
      u: "josec",
      p: "josecpass123",
      roles: [{ role: "readWrite", db: dbname }],
    },
    {
      u: "sarai",
      p: "saraipass123",
      roles: [{ role: "readWrite", db: dbname }],
    },
  ];
  const db = db.getSiblingDB(dbname);
  users.forEach(({ u, p, roles }) => {
    if (!db.getUser(u)) db.createUser({ user: u, pwd: p, roles });
  });
})();
