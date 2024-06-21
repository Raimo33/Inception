#!/bin/sh

/usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
pid="$!"

sleep 20

envsubst < create_db.sql > create_db.sql
envsubst < create_user.sql > create_user.sql
mysql -u root -p${DB_ROOT_PASSWORD} < create_db.sql
mysql -u root -p${DB_ROOT_PASSWORD} < create_user.sql

mysqladmin -u root -p${DB_ROOT_PASSWORD} -h localhost shutdown

wait "$pid"