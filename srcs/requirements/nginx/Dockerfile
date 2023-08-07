FROM debian:buster

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install nginx -y && \
    apt-get install vim -y && \
    apt-get install curl -y && \
    apt-get install openssl -y


RUN mkdir -p /etc/nginx/ssl


RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj '/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=ajaidi.42.fr/UID=ajaidi'

# ENTRYPOINT [ "" ]