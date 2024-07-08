#!/bin/ash

#TODO non funziona (a volte wordpress da:
# wordpress    | Error: Error establishing a database connection. This either means that the username and password information in your `wp-config.php` file is incorrect or that contact with the database server at `` could not be established. This could mean your host’s database server is down.
# wordpress    | Error: Error establishing a database connection. This either means that the username and password information in your `wp-config.php` file is incorrect or that contact with the database server at `` could not be established. This could mean your host’s database server is down.
# wordpress    | Error: Error establishing a database connection.
# wordpress    | Error: Error establishing a database connection.
# )

while ! mysqladmin ping -h"$DB_HOST" --silent; do
	sleep 1
done

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
	
	wp plugin install redis-cache --activate

	wp config set WP_REDIS_HOST '$REDIS_HOST' --type=constant
	wp config set WP_CACHE true --type=constant

fi

exec "$@"