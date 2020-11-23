FROM gitpod/workspace-mysql



RUN sudo apt-get update -q \
    && sudo apt-get install -y php-dev

RUN wget http://xdebug.org/files/xdebug-2.9.1.tgz \
    && tar -xvzf xdebug-2.9.1.tgz \
    && cd xdebug-2.9.1 \
    && phpize \
    && ./configure \
    && make \
    && sudo mkdir -p /usr/lib/php/20190902 \
    && sudo cp modules/xdebug.so /usr/lib/php/20190902 \
    && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20190902/xdebug.so\n[XDebug]\nxdebug.remote_enable = 1\nxdebug.remote_autostart = 1\n' >> /etc/php/7.4/cli/php.ini"

    # RUN sudo apt-get purge php7.* \
    # && sudo apt-get autoclean \
    # && sudo apt-get autoremove \
    # && sudo apt-get install -yq php7.3 

    RUN sudo apt-get remove -y --purge php7.* \
    && sudo add-apt-repository --remove ppa: ondrej / php \ 
    && sudo apt-get update \ 
    && sudo apt-get install php7.2 php7.2-cli php7.2-common