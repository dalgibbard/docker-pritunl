# Pritunl
# 

FROM ubuntu:14.04

MAINTAINER Darren Gibbard <dalgibbard@gmail.com>

RUN apt-get update -q
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common python-software-properties
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list && echo "deb http://repo.pritunl.com/stable/apt trusty main" | tee /etc/apt/sources.list.d/pritunl.list && apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7F0CEB10 && apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN apt-get update
RUN sudo apt-get install python-software-properties pritunl wget mongodb-org -y
RUN wget --no-check-certificate -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64
RUN chmod +x /usr/local/bin/dumb-init
RUN mkdir -p /data/db

ADD entry.sh /bin/entry.sh

EXPOSE 9700
EXPOSE 1194
#EXPOSE 11194

ENTRYPOINT ["/usr/local/bin/dumb-init", "/bin/entry.sh"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]




