#!/bin/bash

# Function to handle errors
handle_error() {
  local exit_code=$1
  local command=$2
  echo "Error occurred during: '${command}'" >&2
  exit ${exit_code}
}

# Update repositories
apt update -y
if [ $? -ne 0 ]; then
  handle_error 1 "apt update -y"
fi

# Install MariaDB server
apt install mariadb-server -y
if [ $? -ne 0 ]; then
  handle_error 1 "apt install mariadb-server"
fi

# Start MariaDB service
service mariadb start
if [ $? -ne 0 ]; then
  handle_error 1 "service mariadb start"
fi

# Check if required environment variables are set
if [ -z "$DB_USER" ] || [ -z "$DB_NAME" ] || [ -z "$DB_PASS" ]; then
  handle_error 1 "check if required environment variables are set"
fi

# Generate seed file with variable substitution
path_conf="/etc/mysql/mariadb.conf.d"
filename="50-server.cnf"
sed "s/%%DB_NAME%%/$DB_NAME/g; s/%%DB_USER%%/$DB_USER/g; s/%%DB_PASS%%/$DB_PASS/g" template.sql >mariadb_seed.sql
if [ $? -ne 0 ]; then
  handle_error 1 "sed"
fi

# Copy configuration file to destination
cp mariadb.conf "$path_conf/$filename"
if [ $? -ne 0 ]; then
  handle_error 1 "config of mariadb server fialed"
fi

# Seed the database
mysql <mariadb_seed.sql
if [ $? -ne 0 ]; then
  handle_error 1 "seeding mariadb user and db failed"
fi


# Start MariaDB server
# exec mysqld --user=root --console

mariadb

if [ $? -ne 0 ]; then
  handle_error 1 "mysql -d"
fi