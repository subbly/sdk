#!/usr/bin/env bash

cp -r /vagrant/etc/* /etc
service nginx restart
service php5-fpm restart

sudo composer selfupdate -n
