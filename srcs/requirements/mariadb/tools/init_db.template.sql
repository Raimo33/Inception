CREATE DATABASE `${DB_NAME}`;

CREATE USER '${DB_USER}'@'wordpress.backend' IDENTIFIED BY '${DB_USER_PASSWORD}';
CREATE USER '${DB_USER}'@'adminer.backend' IDENTIFIED BY '${DB_USER_PASSWORD}';
CREATE USER 'ping-user'@'wordpress.backend' IDENTIFIED BY '';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ON `${DB_NAME}`.* TO '${DB_USER}'@'wordpress.backend';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ON `${DB_NAME}`.* TO '${DB_USER}'@'adminer.backend';
GRANT USAGE ON `${DB_NAME}`.* TO 'ping-user'@'wordpress.backend';

FLUSH PRIVILEGES;
