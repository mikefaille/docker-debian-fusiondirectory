FROM debian:jessie
MAINTAINER Mattias Fliesberg <mattias@fliesberg.email>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common gnupg && \
    gpg --keyserver keys.gnupg.net --recv-keys E184859262B4981F && \
    gpg -a --export E184859262B4981F | apt-key add - && \
    add-apt-repository 'deb http://repos.fusiondirectory.org/debian wheezy main' && \
    add-apt-repository 'deb http://repos.fusiondirectory.org/debian-extra wheezy main' && \
    apt-get update && \
    apt-get install -y php-mdb2 fusiondirectory fusiondirectory-plugin-mail

COPY config/fusiondirectory/fusiondirectory.conf /etc/fusiondirectory/fusiondirectory.conf

RUN yes Yes | fusiondirectory-setup --check-config

COPY start.sh /start.sh

ENTRYPOINT ["/start.sh"]
