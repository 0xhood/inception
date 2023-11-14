#!/bin/bash

# Function to handle errors
handle_error() {
    local exit_code=$1
    local command=$2
    echo "Error occurred during: '${command}'" >&2
    exit ${exit_code}
}

if [ -z "$DB_NAME" ] || [ -z "$DB_HOST" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ] || [ -z "$ROOT_PASS" ] || [ -z "$DOMAIN_NAME" ] || [ -z "$WP_TITLE" ] || [ -z "$WP_ADMIN" ] || [ -z "$WP_ADMIN_PASS" ] || [ -z "$WP_ADMIN_EMAIL" ] || [ -z "$WP_USER" ] || [ -z "$WP_USER_EMAIL" ] || [ -z "$WP_PASS" ]; then
    handle_error 1 "check if required environment variables are set"
fi
if [ ! -f /var/www/html/index.php ]; then
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
if [ $? -ne 0 ]; then
    handle_error 1 "failed installing wp clif"
fi

chmod +x wp-cli.phar

if [ $? -ne 0 ]; then
    handle_error 1 "failed changing mod"
fi


mv wp-cli.phar /usr/local/bin/wp
if [ $? -ne 0 ]; then
    handle_error 1 "failed moving config"
fi

sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g" /etc/php/7.3/fpm/pool.d/www.conf
if [ $? -ne 0 ]; then
    handle_error 1 "failed changing listen port"
fi

wp --allow-root core download
if [ $? -ne 0 ]; then
    handle_error 1 "failed downloading core files"
fi

# wp --allow-root core config --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS

chmod 777 /var/www/html/wp-config.php

sed -i "s/{{DB-NAME}}/$DB_NAME/g" /var/www/html/wp-config.php
sed -i "s/{{DB-USER}}/$DB_USER/g" /var/www/html/wp-config.php
sed -i "s/{{DB-PASS}}/$DB_PASS/g" /var/www/html/wp-config.php
sed -i "s/{{DB-HOST}}/$DB_HOST/g" /var/www/html/wp-config.php

wp --allow-root core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email

wp --allow-root user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_PASS

# sed -i "s/define( 'WP_DEBUG', false );/define( 'W P_DEBUG', true );/g" /var/www/html/wp-config.php
fi

exec php-fpm7.3 -F
