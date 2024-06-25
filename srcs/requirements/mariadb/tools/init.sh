#!/bin/sh

envsubst < create_db.template.sql > create_db.sql
envsubst < create_user.template.sql > create_user.sql

/usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql &

while ! mysqladmin ping --silent; do
	sleep 1
done

mysql -u root < create_db.sql
mysql -u root < create_user.sql

mysqladmin -u root -h localhost shutdown

rm -rf *.sql
