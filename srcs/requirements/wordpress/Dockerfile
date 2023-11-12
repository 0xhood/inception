FROM debian:buster



WORKDIR /var/www/html

RUN chmod -R 777 /var/www/html
RUN mkdir /run/php/



COPY ./conf/config.bash ./config.bash

COPY ./conf/wp-config.php ./wp-config.php

RUN chmod +x ./config.bash


RUN apt update -y && apt upgrade -y

RUN apt install curl -y

RUN apt install -y php7.3 php-fpm php-mysql mariadb-client

EXPOSE 9000

CMD [ "./config.bash" ]