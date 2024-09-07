#!/bin/sh

while ! mariadb -h mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD mysql;
do
	echo "Waiting for database";
	sleep 2;
done
	echo "Database is ready!"

if [ ! -f wp-config.php ]; then
	wp core download --allow-root
	wp config create --allow-root \
	--dbname=mysql \
	--dbuser=${MYSQL_USER} \
	--dbpass=${MYSQL_PASSWORD} \
	--dbhost=mariadb:3306

	wp core install --allow-root \
		--title=myTitle \
		--admin_user=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASS}  \
		--admin_email=${WP_ADMIN_EMAIL} \
		--skip-email \
		--url='dhorvath.42.fr'

	wp user create --allow-root \
		${WP_USER} \
		${WP_USER_EMAIL} \
		--user_pass=${WP_USER_PASS}

	wp theme install \
		inspiro \
		--activate \
		--allow-root;

	wp option update siteurl "https://dhorvath.42.fr" \
		--allow-root;

	wp option update home "https://dhorvath.42.fr" \
		--allow-root;
fi

chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

loc="/run/php"

if [ ! -d "$loc" ]; then
	mkdir -p "$loc"
fi

/usr/sbin/php-fpm7.4 -F