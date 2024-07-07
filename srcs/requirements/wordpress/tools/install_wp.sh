#!/bin/ash

wp core download --version=6.5.5

wp config create --skip-check \
	--dbname=$DB_NAME \
	--dbuser=$DB_USER \
	--dbpass=$DB_PASSWORD \
	--dbhost=$DB_HOST