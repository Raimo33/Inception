#!/bin/ash

envsubst < init_db.template.sql > init_db.sql

/usr/bin/mysqld --datadir=/var/lib/mysql --user=mysql &

while ! mysqladmin ping --silent; do
	sleep 1
done

mysql -u root < init_db.sql

mysqladmin -u root -h localhost shutdown
rm -rf init_db.sql