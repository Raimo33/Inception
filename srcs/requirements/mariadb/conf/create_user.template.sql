CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
CREATE USER '${DB_SUPERUSER}'@'%' IDENTIFIED BY '${DB_SUPERUSER_PASSWORD}';
GRANT SELECT, INSERT, UPDATE, DELETE ON `${DB_NAME}`.* TO '${DB_USER}'@'%';
GRANT ALL PRIVILEGES ON `${DB_NAME}`.* TO '${DB_SUPERUSER}'@'%';
FLUSH PRIVILEGES;