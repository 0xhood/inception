#!/bin/bash

# Function to handle errors
handle_error() {
  local exit_code=$1
  local command=$2
  echo "Error occurred during: '${command}'" >&2
  exit ${exit_code}
}

apt update -y
if [ $? -ne 0 ]; then
  handle_error 1 "apt update -y"
fi
apt upgrade -y
if [ $? -ne 0 ]; then
  handle_error 1 "apt update -y"
fi
# Install MariaDB server
apt install mariadb-server -y
if [ $? -ne 0 ]; then
  handle_error 1 "apt install mariadb-server"
fi

sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf


# Check if required environment variables are set
if [ -z "$DB_USER" ] || [ -z "$DB_NAME" ] || [ -z "$DB_PASS" ]; then
  handle_error 1 "check if required environment variables are set"
fi

# Generate seed file with variable substitution
sed "s/%%DB_NAME%%/$DB_NAME/g; s/%%DB_USER%%/$DB_USER/g; s/%%DB_PASS%%/$DB_PASS/g" template.sql >mariadb_seed.sql
if [ $? -ne 0 ]; then
  handle_error 1 "sed"
fi


# Start MariaDB service
service mariadb start
if [ $? -ne 0 ]; then
  handle_error 1 "service mariadb start"
fi


# # Seed the database
mysql  <mariadb_seed.sql
if [ $? -ne 0 ]; then
  handle_error 1 "seeding mariadb user and db failed"
fi

kill `cat /var/run/mysqld/mysqld.pid`
service mariadb stop
mysqld