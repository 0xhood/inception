APP:
	sudo docker-compose -f srcs/docker-compose.yml up --build
soft:
	sudo docker-compose -f srcs/docker-compose.yml up

clean:
	sudo docker stop `sudo docker ps -aq`;sudo docker rm `sudo docker ps -aq`;sudo docker images `sudo docker images -aq`
fclean:
	sudo docker system prune --all; sudo rm -rf /home/ajaidi/data/wordpress/* /home/ajaidi/data/mariadb/*
re: fclean APP

.PHONY: APP clean fclean re
