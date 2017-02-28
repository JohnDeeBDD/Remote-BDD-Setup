#!/bin/sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo chmod -R 777 /var/www
sudo apt-get -f install
sudo apt-get -y install nodejs-legacy
sudo apt-get -y install php
sudo apt-get -y install php-curl
sudo apt-get -y install php-gd
sudo apt-get -y install php-mbstring
sudo apt-get -y install php-mcrypt
sudo apt-get -y install php-xml
sudo apt-get -y install php-xmlrpc
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
sudo chmod -R 777 /var/www
cd /var/www/html
sudo wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
sudo mv -v /var/www/html/wordpress/* /var/www/html/
sudo rm -fr /var/www/html/wordpress
sudo rm /var/www/html/index.html
sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo chmod -R g+w /var/www/html/wp-content/themes
cd /var/www/html/wp-content/plugins
sudo rm -fr akismet
sudo rm hello.php
sudo git clone https://github.com/Hitman007/Wordpress-Pickles.git
sudo git clone https://Hitman007@bitbucket.org/Hitman007/crg_mods.git
mysql -u root -ppassword << EOF
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF
sudo reboot
