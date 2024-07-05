#!/bin/ash

sed -i "s/^bind-address\s*=.*/bind-address = mariadb.backend/" /etc/my.cnf.d/mariadb-server.cnf

exec $@
