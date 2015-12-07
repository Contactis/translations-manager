FROM ubuntu:14.04

RUN apt-get update && apt-get install -y build-essential curl git libfreetype6 libfontconfig1 python-pygments
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

RUN apt-get remove -y python-pygments

CMD gulp db:restore && gulp build --no-tests
