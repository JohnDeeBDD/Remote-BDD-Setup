#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/wp1.sh)
# Directions: https://generalchicken.net/bdd-wp-aws/

#chromedriver
#cd /var/www
#sudo wget -y https://chromedriver.storage.googleapis.com/84.0.4147.30/chromedriver_linux64.zip
#unzip -y chromedriver_linux64.zip
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
#sudo apt-get -y install google-chrome-stable

clear
echo What is the domain name of the site?
read varurl

sudo apt-get -y update
sudo apt-get -y upgrade 

#sudo apt-get -f install
#sudo apt-get -y install nodejs-legacy
#sudo apt-get -y install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
#sudo apt-get -y install vnc4server

#from https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions

sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get -y update
sudo apt-get -y upgrade 
sudo apt-get -y install php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl
#sudo apt-get -y install php-hash php-json php-sodium php-openssl

sudo apt-get -y install build-essential checkinstall && apt-get build-dep imagemagick -y
sudo apt-get -y install imagemagick
sudo apt-get -y install php-imagick

#sudo apt-get -y install firefox
#sudo apt-get -y install default-jdk
sudo apt-get -y install libxss1 libappindicator1 libindicator7
sudo apt-get -y install openjdk-8-jre openjdk-8-jre-headless xvfb libxi6 libgconf-2-4
#sudo apt-get -y install npm
sudo apt-get -y install git zip unzip php-zip
sudo apt-get -y install expect
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
#sudo apt-get -y install lamp-server^
#sudo a2enmod rewrite
sudo apt-get -y install php-mbstring

sudo apt -y install apache2
sudo ufw allow in "Apache Full"
sudo apt -y install mysql-server

#setup swap on Ubuntu:
#sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
#sudo /sbin/mkswap /var/swap.1
#sudo /sbin/swapon /var/swap.1

# Composer:
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
