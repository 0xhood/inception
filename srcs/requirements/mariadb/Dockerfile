FROM debian:buster

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server -y

WORKDIR /db

COPY ./conf ./

RUN chmod u+x ./config.sh

CMD [ "/bin/bash", "./config.sh" ]