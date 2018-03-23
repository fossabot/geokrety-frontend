# doc : https://docs.docker.com/engine/reference/builder/#shell
# start from image
FROM webdevops/apache:latest

LABEL maintainer="boly38@gmail.com"

RUN echo mise à jour apt
RUN apt-get update

# RUN echo generation des certificats pour apache avec certbot (PROD)
# 
# # https://doc.ubuntu-fr.org/tutoriel/securiser_apache2_avec_ssl
# RUN apt --assume-yes install software-properties-common
# RUN add-apt-repository ppa:certbot/certbot
# RUN apt update
# RUN apt --assume-yes install certbot
# RUN certbot certonly --standalone --preferred-challenges tls-sni -d gkfront.com -m boly38@gmail.com --agree-tos --non-interactive || echo force 0 status to continue
# 
# RUN apt --assume-yes install python-certbot-apache
# RUN certbot --authenticator standalone --installer apache -m boly38@gmail.com --agree-tos --non-interactive || echo force 0 status to continue


RUN echo generation des certificats self-signed (DEV)

RUN mkdir -p /var/pk 
RUN chmod 777 /var/pk
RUN openssl req -x509 -newkey rsa:4096 -days 365 -nodes -subj "/C=FR/ST=Geokrety/L=France" -keyout /var/pk/key.pem -out /var/pk/cert.pem

RUN echo update global apache conf
COPY exposed/docker/apache2.conf /etc/apache2/apache2.conf
RUN echo update docker apache  site
COPY exposed/docker/10-server.conf /opt/docker/etc/httpd/conf.d/10-server.conf

RUN echo restart apache

RUN a2enmod proxy_http
RUN service apache2 restart
