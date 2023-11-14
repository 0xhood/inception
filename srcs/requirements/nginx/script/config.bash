#!/bin/bash

# Function to handle errors
handle_error() {
    local exit_code=$1
    local command=$2
    echo "Error occurred during: '${command}'" >&2
    exit ${exit_code}
}

openssl genpkey -algorithm RSA -out private.key -pkeyopt rsa_keygen_bits:2048
if [ $? -ne 0 ]; then
    handle_error 1 "failed generating pkey"
fi
openssl req -new -key private.key -out csr.csr -subj "/C=US/ST=State/L=City/O=Organization/CN=$DOMAIN_NAME"
if [ $? -ne 0 ]; then
    handle_error 1 "failed generating csr file"
fi
openssl x509 -req -in csr.csr -signkey private.key -out certificate.crt -days 365
if [ $? -ne 0 ]; then
    handle_error 1 "failed generating certification"
fi
mv private.key /etc/nginx/conf.d
if [ $? -ne 0 ]; then
    handle_error 1 "failed moving pk to nginx conf folder"
fi
mv certificate.crt /etc/nginx/conf.d
if [ $? -ne 0 ]; then
    handle_error 1 "failed moving certification to nginx conf folder"
fi
cp conf/default.conf /etc/nginx/conf.d/default.conf
if [ $? -ne 0 ]; then
    handle_error 1 "failed posting imported conf to nginx default conf"
fi

chmod 777 /var/www/html

nginx -g "daemon off;"
