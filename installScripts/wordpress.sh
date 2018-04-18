#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/wordpress.sh)
# Directions: https://wp-bdd.com/bdd-wp-aws/
#
#sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo dpkg -i google-chrome*.deb
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get -y upgrade 
sudo apt-get install google-chrome-stable
sudo apt-get -f install
sudo apt-get -y install nodejs-legacy
sudo apt-get -y install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
sudo apt-get -y install vnc4server
sudo apt-get -y install php php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc
sudo apt-get -y install firefox
sudo apt-get -y install default-jdk
sudo apt-get -y install libxss1 libappindicator1 libindicator7
sudo apt-get -y install openjdk-8-jre-headless xvfb libxi6 libgconf-2-4
sudo apt-get -y install npm
sudo apt-get -y install git
sudo apt-get -y install zip
sudo apt-get -y install unzip
sudo apt-get -y install php-zip
sudo apt-get -y install expect
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get -y install lamp-server^
sudo a2enmod rewrite

#setup swap:
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1

# Composer:
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Install Wordpress:
sudo chmod -R 777 /var/www
cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
sudo mv -v /var/www/html/wordpress/* /var/www/html/
sudo rm -fr /var/www/html/wordpress
sudo rm /var/www/html/index.html
sudo rm /var/www/html/latest.tar.gz

sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo chmod -R g+w /var/www/html/wp-content/themes

#sudo chown -R ubuntu:www-data /var/www/html
#sudo find /var/www/html -type d -exec chmod g+s {} \;
#sudo chmod g+w /var/www/html/wp-content
#sudo chmod -R g+w /var/www/html/wp-content/plugins
#sudo chmod -R g+w /var/www/html/wp-content/themes

#Coddiad
sudo git clone https://github.com/Codiad/Codiad /var/www/html/codiad
sudo touch /var/www/html/codiad/config.php
sudo chown www-data:www-data -R /var/www/html/codiad/

mysql -u root -ppassword << EOF
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF

mysql -u root -ppassword << EOF
CREATE DATABASE wordpress_unit_test DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON wordpress_unit_test.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF

# Wordpress plugins:
cd /var/www/html/wp-content/plugins
sudo rm -fr akismet
sudo rm hello.php
#sudo git clone https://github.com/Hitman007/CRG-Mods.git
sudo git clone https://github.com/JohnDeeBDD/WPbdd.git
sudo chmod -R 777 /var/www
cd /var/www/html/wp-content/plugins/WPbdd
composer install
#install phantomJS
sudo apt-get -y install build-essential chrpath libssl-dev libxft-dev
sudo apt-get -y install libfreetype6 libfreetype6-dev
sudo apt-get -y install libfontconfig1 libfontconfig1-dev
#to run phantomjs:
# ./phantomjs --webdriver=4444

sudo chmod 777 -R /var/www/html
sudo apt-get clean
sudo reboot
