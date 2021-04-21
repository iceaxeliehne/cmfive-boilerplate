FROM gitpod/workspace-mysql

ENV APACHE_DOCROOT_IN_REPO=""

# prevent install locking up o TZ or other user inputs
ENV DEBIAN_FRONTEND=noninteractive

USER root

# set up mysql 5.7
RUN service mysql stop

RUN apt-get remove --purge mysql* -y
#sudo apt-get purge mysql*
#sudo apt autoremove && sudo apt autoclean
#sudo apt-get remove dbconfig-mysql

RUN apt-get purge mysql* -y
RUN apt-get autoremove -y
RUN apt-get autoclean -y
#RUN apt-get remove dbconfig-mysql -y

RUN apt-get dist-upgrade

# RUN cd /tmp
# RUN curl -OL https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
# RUN dpkg -i mysql-apt-config_0.8.13-1_all.deb

RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
RUN dpkg -i mysql-apt-config_0.8.15-1_all.deb

RUN rm -rf /etc/mysql
RUN rm -rf /var/lib/mysql*

RUN apt-get update

RUN apt-cache policy mysql-server

#RUN apt-get install -f mysql-client=5.7.33-1ubuntu18.04 mysql-community-server=5.7.33-1ubuntu18.04 mysql-server=5.7.33-1ubuntu18.04
RUN apt-get install -f mysql-client mysql-community-server mysql-server -y


# set up basics for apt-get'ting
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get install -y locales-all

# allow retries & break up apt-get for recovery
# of build from apt cache in case of connection failures
RUN apt-get install -y -o "APT::Acquire::Retries=6" \
    vim supervisor gnupg2	

RUN apt-get update
RUN apt-get install -y -o "APT::Acquire::Retries=6" \
    php7.2-fpm

RUN apt-get update
RUN apt-get install -y -o "APT::Acquire::Retries=6" \
    php7.2-zip \
    php7.2-curl \
    php7.2-gd \
    php7.2-json \
    php7.2-mysql \
    php7.2-xml \
    php7.2-bcmath \
    php7.2-mbstring   
    # libapache2-mod-php7.2

# toolbox extras, to allow for DB commands & subnet examination etc
RUN apt-get update
RUN apt-get install -y -o "APT::Acquire::Retries=6" \
    git \
    iputils-ping \
    curl 
    # default-mysql-client

# PHP extras, for test+debug
RUN apt-get update
RUN apt-get install -y -o "APT::Acquire::Retries=6" \ 
    phpunit \
    php-xdebug
    
    
RUN apt-get install -y -o "APT::Acquire::Retries=6" \
    libapache2-mod-php7.2

USER root    


RUN a2dismod php7.4 
RUN a2enmod php7.2 
RUN update-alternatives --set php /usr/bin/php7.2

# bootstrap environment
#WORKDIR /bootstrap
#COPY ./stage .

#RUN cp fpm/* /etc/php/7.2/fpm/
#RUN cp nginx/nginx.conf /etc/nginx/nginx.conf
#RUN cp nginx/default.conf /etc/nginx/conf.d/default.conf
#RUN cp supervisord.conf /etc/supervisord.conf

#RUN mkdir /run/php

#RUN chmod -R 777 start.sh
#CMD ["/bootstrap/start.sh"]
