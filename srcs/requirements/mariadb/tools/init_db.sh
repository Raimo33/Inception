#!/bin/sh

/usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
pid="$!"

sleep 10

envsubst < /tmp/create_db.sql > /tmp/create_db_substituted.sql
mysql -u root < /tmp/create_db_substituted.sql
rm /tmp/create_db_substituted.sql

mysqladmin -u root shutdown
wait "$pid"
exec /usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql
