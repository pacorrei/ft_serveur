FROM debian:buster
MAINTAINER pacorrei <pacorrei@student.42.fr>
COPY srcs/nginx_local_host.conf ./root/
COPY srcs/config.inc.php ./root/
COPY srcs/start.sh .
COPY srcs/wp-config.php ./root/
#COPY srcs/init.sql ./root/
RUN apt-get update && apt-get -y upgrade && apt-get install -y nginx
RUN apt-get install -y wget && apt-get install -y mariadb-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring php-json php-curl php-gd php-intl
CMD bash start.sh
EXPOSE 80 443