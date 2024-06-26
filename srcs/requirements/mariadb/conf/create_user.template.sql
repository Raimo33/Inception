CREATE USER '${DB_USER}'@'wordpress.backend' IDENTIFIED BY '${DB_USER_PASSWORD}';
CREATE USER '${DB_SUPERUSER}'@'wordpress.backend' IDENTIFIED BY '${DB_SUPERUSER_PASSWORD}';
GRANT SELECT, INSERT, UPDATE, DELETE ON `${DB_NAME}`.* TO '${DB_USER}'@'wordpress.backend';
GRANT ALL PRIVILEGES ON `${DB_NAME}`.* TO '${DB_SUPERUSER}'@'wordpress.backend';
FLUSH PRIVILEGES;