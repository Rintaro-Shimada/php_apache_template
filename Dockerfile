FROM php:7.3-apache

RUN apt update -yqq && \
   docker-php-ext-install mbstring && \
   docker-php-ext-install pdo_mysql

ADD ./php.ini /usr/local/etc/php/php.ini
ADD ./httpd.conf /etc/apache2/sites-enabled/httpd.conf
RUN mkdir /var/log/httpd/ -p
RUN a2enmod rewrite && a2enmod headers && service apache2 restart

ENV TZ Asia/Tokyo
RUN echo "${TZ}" > /etc/timezone \
   && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /var/www/html/