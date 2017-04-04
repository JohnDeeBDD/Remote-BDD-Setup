#!/bin/sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo chmod -R 777 /var/www
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
sudo apt-get -f install
sudo apt-get -y install nodejs-legacy
sudo apt-get -y install xfce4
sudo apt-get -y install vnc4server
sudo apt-get -y install php
sudo apt-get -y install php-curl
sudo apt-get -y install php-gd
sudo apt-get -y install php-mbstring
sudo apt-get -y install php-mcrypt
sudo apt-get -y install php-xml
sudo apt-get -y install php-xmlrpc
sudo apt-get -y install firefox
sudo apt-get -y install default-jdk
sudo apt-get -y install libxss1
sudo apt-get -y install libappindicator1
sudo apt-get -y install libindicator7
sudo apt-get -y install npm
sudo apt-get -y install zip
sudo apt-get -y install unzip
sudo apt-get -y install php-zip
sudo apt-get -y install lamp-server^
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
sudo a2enmod rewrite
