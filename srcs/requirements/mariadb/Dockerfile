FROM debian:bullseye

RUN apt update -y \
&& apt install -y mariadb-server mariadb-client

COPY mariadb.cnf /etc/mariadb.cnf.d/mariadb.cnf
RUN chmod 644 /etc/mariadb.cnf.d/mariadb.cnf

COPY ./setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["sh", "/tmp/setup.sh"]