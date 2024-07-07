#!/bin/ash

#TODO aspettare mariadb

if ! wp core is-installed; then

	wp core install --skip-email \
		--url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_SUPERUSER \
		--admin_password=$WP_SUPERUSER_PASSWORD \
		--admin_email=$WP_SUPERUSER_EMAIL
	
	wp user create \
		$WP_USER \
		$WP_USER_EMAIL \
		--role=author \
		--user_pass=$WP_USER_PASSWORD
fi

exec "$@"