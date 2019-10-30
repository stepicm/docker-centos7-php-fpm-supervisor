FROM centos:7
MAINTAINER Martin Stepic <grft801@airmail.cc>

RUN yum -y --setopt=tsflags=nodocs update
RUN yum -y --setopt=tsflags=nodocs --nogpgcheck install epel-release
RUN yum -y --setopt=tsflags=nodocs --nogpgcheck install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y --setopt=tsflags=nodocs --nogpgcheck install php72u-cli \
    php72u-fpm \
    php72u-bcmath \
    php72u-gd \
    php72u-intl \
    php72u-json \
    php72u-ldap  \
    php72u-mbstring \
    php72u-mcrypt \
    php72u-opcache \
    php72u-pdo \
    php72u-pear  \
    php72u-pecl-apcu \
    php72u-pecl-imagick \
    php72u-pecl-redis \
    php72u-pecl-xdebug  \
    php72u-pgsql \
    php72u-mysqlnd \
    php72u-soap \
    php72u-tidy \
    php72u-xml \
    php72u-xmlrpc \
    supervisor \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    cronie
RUN yum clean all
RUN rm /etc/php-fpm.d/www.conf
RUN rm /etc/supervisord.conf
RUN mkdir -p /run/php-fpm
RUN chmod 777 /run/php-fpm

ADD fpm.conf /etc/php-fpm.d/
ADD supervisor.conf /etc/supervisord.conf

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer self-update

CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]

EXPOSE 9000 9111