FROM 783872453/ubuntu-unattended-upgrades:latest

RUN DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get upgrade --yes \
 && echo mysql-server mysql-server/root_password password initial | debconf-set-selections \
 && echo mysql-server mysql-server/root_password_again password initial | debconf-set-selections \
 && apt-get install --yes --no-install-recommends \
                    apache2 libapache2-mod-php \
                    php php-common php-gd php-curl php-mail php-mail-mime php-db php-mysqlnd \
                    mysql-server mysql-client libmysqlclient-dev 

COPY supervisor-apache2.conf /etc/supervisor/conf.d/apache2.conf
COPY supervisor-mysql.conf /etc/supervisor/conf.d/mysql.conf
