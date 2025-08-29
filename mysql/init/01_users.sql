-- ~/db-stack/mysql-init/01-init.sql
CREATE DATABASE IF NOT EXISTS uapaSoftwareLibreDB
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

CREATE USER IF NOT EXISTS 'adminuser'@'%' IDENTIFIED BY 'adminsomepass';
GRANT ALL PRIVILEGES ON uapaSoftwareLibreDB.* TO 'ubuntu'@'%';

CREATE USER IF NOT EXISTS 'user1'@'%' IDENTIFIED BY 'somepass';
CREATE USER IF NOT EXISTS 'user2'@'%' IDENTIFIED BY 'somepass';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX ON uapaSoftwareLibreDB.* TO
  'user1'@'%', 'user2'@'%';

FLUSH PRIVILEGES;
