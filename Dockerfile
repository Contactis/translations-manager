FROM phusion/baseimage

ENV MYSQL_PASSWORD yourRootPassword

RUN echo "mysql-server mysql-server/root_password password $MYSQL_PASSWORD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD" | debconf-set-selections

RUN apt-get update && apt-get install -y build-essential curl git libfreetype6 libfontconfig1 mysql-server

RUN service mysql start && \
    mysql -u root -p$MYSQL_PASSWORD -e "CREATE DATABASE transman CHARACTER SET utf8 COLLATE utf8_general_ci;" && \
    service mysql stop

WORKDIR /

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get install -y nodejs

RUN npm cache clean -f
RUN npm install -g n
RUN n stable

RUN npm install -g gulp bower sequelize-cli groc

ADD . /tr

WORKDIR /tr

RUN npm prune
RUN npm install

WORKDIR /tr/frontend

RUN bower --allow-root prune
RUN bower --allow-root install

WORKDIR /tr

RUN cp server/datasources.sample.json server/datasources.json

ADD init_scripts/mysql.sh /etc/service/mysql/run
ADD init_scripts/tr.sh /etc/service/tr/run

EXPOSE 3000
CMD ["/sbin/my_init", "--enable-insecure-key"]
