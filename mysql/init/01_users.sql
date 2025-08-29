CREATE DATABASE IF NOT EXISTS uapaSoftwareLibreDB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- admin del schema
CREATE USER IF NOT EXISTS 'ubuntu'@'localhost'   IDENTIFIED BY 'ubuntupass123';
CREATE USER IF NOT EXISTS 'ubuntu'@'127.0.0.1'   IDENTIFIED BY 'ubuntupass123';
GRANT ALL PRIVILEGES ON uapaSoftwareLibreDB.* TO 'ubuntu'@'localhost', 'ubuntu'@'127.0.0.1';

-- developers con permisos razonables
-- (puedes ajustar; estos permiten crear/alterar tablas e índices en el schema)
SET @db := 'uapaSoftwareLibreDB';
SET @privs := 'SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER,INDEX';

-- helper para no repetir
-- david
CREATE USER IF NOT EXISTS 'david'@'localhost'     IDENTIFIED BY 'davidpass123';
CREATE USER IF NOT EXISTS 'david'@'127.0.0.1'     IDENTIFIED BY 'davidpass123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER,INDEX ON uapaSoftwareLibreDB.* TO 'david'@'localhost', 'david'@'127.0.0.1';

-- frank
CREATE USER IF NOT EXISTS 'frank'@'localhost'     IDENTIFIED BY 'frankpass123';
CREATE USER IF NOT EXISTS 'frank'@'127.0.0.1'     IDENTIFIED BY 'frankpass123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER,INDEX ON uapaSoftwareLibreDB.* TO 'frank'@'localhost', 'frank'@'127.0.0.1';

-- joanv
CREATE USER IF NOT EXISTS 'joanv'@'localhost'     IDENTIFIED BY 'joanvpass123';
CREATE USER IF NOT EXISTS 'joanv'@'127.0.0.1'     IDENTIFIED BY 'joanvpass123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER,INDEX ON uapaSoftwareLibreDB.* TO 'joanv'@'localhost', 'joanv'@'127.0.0.1';

-- joel
CREATE USER IF NOT EXISTS 'joel'@'localhost'      IDENTIFIED BY 'joelpass123';
CREATE USER IF NOT EXISTS 'joel'@'127.0.0.1'      IDENTIFIED BY 'joelpass123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER,INDEX ON uapaSoftwareLibreDB.* TO 'joel'@'localhost', 'joel'@'127.0.0.1';

-- josec
CREATE USER IF NOT EXISTS 'josec'@'localhost'     IDENTIFIED BY 'josecpass123';
CREATE USER IF NOT EXISTS 'josec'@'127.0.0.1'     IDENTIFIED BY 'josecpass123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER,INDEX ON uapaSoftwareLibreDB.* TO 'josec'@'localhost', 'josec'@'127.0.0.1';

-- sarai
CREATE USER IF NOT EXISTS 'sarai'@'localhost'     IDENTIFIED BY 'saraipass123';
CREATE USER IF NOT EXISTS 'sarai'@'127.0.0.1'     IDENTIFIED BY 'saraipass123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER,INDEX ON uapaSoftwareLibreDB.* TO 'sarai'@'localhost', 'sarai'@'127.0.0.1';

FLUSH PRIVILEGES;

