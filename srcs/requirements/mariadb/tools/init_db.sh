#!/bin/bash
set -e

# Initialize the MariaDB data directory if it doesn't already exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB server in the background
echo "Starting MariaDB server..."
/usr/bin/mysqld_safe --datadir='/var/lib/mysql' &

# Wait for MariaDB to start
echo "Waiting for MariaDB to start..."
sleep 10

# Create database and user
echo "Creating database and user..."
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL

# Shut down MariaDB server
echo "Shutting down MariaDB server..."
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Start MariaDB server normally
echo "Starting MariaDB server normally..."
exec /usr/bin/mysqld_safe --datadir='/var/lib/mysql'
