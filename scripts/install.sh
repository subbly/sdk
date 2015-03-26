#!/usr/bin/env bash

apt-get update -y
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

apt-get install -y nginx php5-fpm php5-gd php5-common php5-curl php5-mcrypt php5-mysql php5-intl php5-xdebug php5-cli php-apc mysql-server mysql-client-core-5.5 mysql-client-5.5 git

mkdir /usr/local/bin

wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit

php -r "readfile('https://getcomposer.org/installer');" | php
mv composer.phar /usr/local/bin/composer

wget http://get.sensiolabs.org/php-cs-fixer.phar -O php-cs-fixer
sudo chmod a+x php-cs-fixer
sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer

php5enmod mcrypt
/etc/init.d/php5-fpm restart

mysql -uroot -proot -e "create database subbly_shop_dev"

cd /var/www/
git clone git@github.com:subbly/cms.git subbly-shop.dev/

cd /var/www/subbly-shop.dev/
composer install -n
php artisan migrate --package=cartalyst/sentry
php artisan migrate
php artisan db:seed
