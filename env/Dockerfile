# doc : https://docs.docker.com/engine/reference/builder/#shell
# start from image
FROM webdevops/apache:latest

LABEL maintainer="boly38@gmail.com"

# RUN apt-get update
# RUN apt-get install wget

RUN echo update global apache conf
COPY exposed/docker/apache2.conf /etc/apache2/apache2.conf
RUN echo update docker apache  site
COPY exposed/docker/10-server.conf /opt/docker/etc/httpd/conf.d/10-server.conf