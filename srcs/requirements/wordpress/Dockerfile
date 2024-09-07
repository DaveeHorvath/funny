FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y wget \
	php \
	php-fpm \
	php-mysql php-phar php-curl php-xml php-gd php-mbstring \
	mariadb-client

COPY conf/www.conf /etc/php/7.4/fpm/pool.d
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www/html && \
    cd /var/www/html && \
    tar -xzf /var/www/html/wordpress-6.0.tar.gz && \
    rm /var/www/html/wordpress-6.0.tar.gz

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/configurer.sh /tmp/configurer.sh
WORKDIR /var/www/html/wordpress

ENTRYPOINT ["sh", "/tmp/configurer.sh"]