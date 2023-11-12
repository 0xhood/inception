FROM debian:buster

RUN apt update -y && apt upgrade -y
RUN apt install -y nginx vim openssl

WORKDIR /app

COPY . .

EXPOSE 4000

ENTRYPOINT [ "bash", "script/config.bash" ]