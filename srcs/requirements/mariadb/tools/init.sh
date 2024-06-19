#!/bin/sh

/usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
pid="$!"

sleep 10

envsubst < create_db.sql > create_db.sql
envsubst < create_user.sql > create_user.sql
mysql -u root < create_db.sql
mysql -u root < create_user.sql

mysqladmin -u root shutdown

wait "$pid"