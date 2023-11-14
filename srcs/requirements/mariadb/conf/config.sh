#!/bin/bash

# Function to handle errors
handle_error() {
    local exit_code=$1
    local command=$2
    echo "Error occurred during: '${command}'" >&2
    exit ${exit_code}
}

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ] || [ -z "$ROOT_PASS" ]; then
    handle_error 1 "check if required environment variables are set"
fi

service mysql start


sed -i "s/{{DB_NAME}}/$DB_NAME/g" seed.sql
if [ $? -ne 0 ]; then
    handle_error 1 "failed expanding db name var in seed.sql"
fi
sed -i "s/{{DB_USER}}/$DB_USER/g" seed.sql
if [ $? -ne 0 ]; then
    handle_error 1 "failed expanding db username var in seed.sql"
fi
sed -i "s/{{DB_PASS}}/$DB_PASS/g" seed.sql
if [ $? -ne 0 ]; then
    handle_error 1 "failed expanding db user pass var in seed.sql"
fi
sed -i "s/{{ROOT_PASS}}/$ROOT_PASS/g" seed.sql
if [ $? -ne 0 ]; then
    handle_error 1 "failed expanding db root pass var in seed.sql"
fi

mysql <seed.sql

kill $(cat /var/run/mysqld/mysqld.pid)

sed -i "s/bind-address            = 127.0.0.1/bind-address           = 0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
if [ $? -ne 0 ]; then
    handle_error 1 "changing mariadb server acceess failed"
fi

service mysql stop


mysqld
