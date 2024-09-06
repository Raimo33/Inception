#!/bin/ash

{
	while ! mariadb-admin ping -h $DB_HOST -u ping-user --silent; do
		sleep 1
	done

	if ! wp core is-installed; then

		wp core install --skip-email \
			--url=$WORDPRESS_URL \
			--title=$WORDPRESS_TITLE \
			--admin_user=$WORDPRESS_SUPERUSER \
			--admin_password=$WORDPRESS_SUPERUSER_PASSWORD \
			--admin_email=$WORDPRESS_SUPERUSER_EMAIL

		wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
			--role=author \
			--user_pass=$WORDPRESS_USER_PASSWORD

		wp plugin install redis-cache --activate

		wp config set WORDPRESS_REDIS_HOST '$REDIS_HOST' --type=constant
		wp config set WORDPRESS_CACHE true --type=constant

	fi
} > /var/log/setup.log 2>&1

exec "$@"
