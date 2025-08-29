-- ~/db-stack/mysql-init/01-init.sql
CREATE DATABASE IF NOT EXISTS uapaSoftwareLibreDB
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Admin del schema
CREATE USER IF NOT EXISTS 'ubuntu'@'%' IDENTIFIED BY 'ubuntupass123';
GRANT ALL PRIVILEGES ON uapaSoftwareLibreDB.* TO 'ubuntu'@'%';

-- Privilegios razonables para el resto
CREATE USER IF NOT EXISTS 'david'@'%' IDENTIFIED BY 'davidpass123';
CREATE USER IF NOT EXISTS 'frank'@'%' IDENTIFIED BY 'frankpass123';
CREATE USER IF NOT EXISTS 'joanv'@'%' IDENTIFIED BY 'joanvpass123';
CREATE USER IF NOT EXISTS 'joel'@'%'  IDENTIFIED BY 'joelpass123';
CREATE USER IF NOT EXISTS 'josec'@'%' IDENTIFIED BY 'josecpass123';
CREATE USER IF NOT EXISTS 'sarai'@'%' IDENTIFIED BY 'saraipass123';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX ON uapaSoftwareLibreDB.* TO
  'david'@'%', 'frank'@'%', 'joanv'@'%', 'joel'@'%', 'josec'@'%', 'sarai'@'%';

FLUSH PRIVILEGES;
