#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/wordpress.sh)
# Directions: https://generalchicken.net/bdd-wp-aws/
# nano ~/.ssh/authorized_keys

#chromedriver
#cd /var/www
#sudo wget -y https://chromedriver.storage.googleapis.com/84.0.4147.30/chromedriver_linux64.zip
#unzip -y chromedriver_linux64.zip

clear
echo What is the domain name of the site?
read varurl
sudo apt -y update
sudo apt -y upgrade
sudo snap install node --classic
sudo apt install -y python2-minimal
sudo mkdir ~/cloud9
sudo apt -y install python3-pip

#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
#sudo apt-get -y install google-chrome-stable

wget --no-verbose -O /tmp/chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_88.0.4324.182-1_amd64.deb
sudo apt install -y /tmp/chrome.deb --allow-downgrades
sudo rm /tmp/chrome.deb 
sudo apt-get -y install net-tools
#sudo apt-get -f install
#sudo apt-get -y install nodejs-legacy
#sudo apt-get -y install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
#sudo apt-get -y install vnc4server

#from https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions
#sudo apt install -y php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl
#sudo apt install -y php7.2-common php7.2-mysql php7.2-xml php7.2-xmlrpc php7.2-curl php7.2-gd php7.2-imagick php7.2-cli php7.2-dev php7.2-imap php7.2-mbstring php7.2-opcache php7.2-soap php7.2-zip php7.2-intl
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt -y install php7.4

#sudo apt-get -y install php-hash php-json php-sodium php-openssl

#sudo apt-get install -y build-essential checkinstall && apt-get build-dep imagemagick
#sudo apt install -y imagemagick
#sudo apt install -y php-imagick

#sudo apt-get -y install firefox
#sudo apt-get -y install default-jdk
sudo apt-get -y install libxss1 libappindicator1 libindicator7
sudo apt-get -y install openjdk-8-jre openjdk-8-jre-headless xvfb libxi6 libgconf-2-4
#sudo apt-get -y install npm
sudo apt-get -y install git zip unzip php-zip
sudo apt-get -y install expect
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get -y install lamp-server^
sudo a2enmod rewrite
sudo apt-get -y install php-mbstring


#setup swap on Ubuntu:
#sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
#sudo /sbin/mkswap /var/swap.1
#sudo /sbin/swapon /var/swap.1

# Composer:
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

#php8.2
#sudo apt install -y php8.2-common php8.2-mysql php8.2-xml php8.2-xmlrpc php8.2-curl php8.2-gd php8.2-imagick php8.2-cli php8.2-dev php8.2-imap php8.2-mbstring php8.2-opcache php8.2-soap php8.2-zip php8.2-intl


# Install Wordpress:
sudo chmod -R 777 /var/www
sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
sudo mv -v /var/www/html/wordpress/* /var/www/html/
sudo rm -fr /var/www/html/wordpress
sudo rm /var/www/html/index.html
sudo rm /var/www/html/latest.tar.gz

wp config create --dbname=wordpress --dbuser=wordpressuser --dbpass=password
wp core install --url=http://$varurl --title="Dev Site" --admin_user=Codeception --admin_password=password --admin_email=codeception@email.com --skip-email

#setup PHP to own the WordPress directory:
sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo chmod -R g+w /var/www/html/wp-content/themes

#Coddiad IDE. Access Codeiad via a browser @ {domainURL.com/codiad}
#sudo git clone https://github.com/Codiad/Codiad /var/www/html/codiad
#sudo touch /var/www/html/codiad/config.php
#sudo chown www-data:www-data -R /var/www/html/codiad/

mysql -u root -ppassword << EOF
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EOF

mysql -u root -ppassword << EOF
CREATE DATABASE wordpress_unit_test DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL PRIVILEGES ON wordpress_unit_test.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# Wordpress plugins:
cd /var/www/html/wp-content/plugins
sudo rm -fr akismet
sudo rm hello.php
wp plugin install disable-administration-email-verification-prompt
wp plugin install email-log
wp plugin install disable-welcome-messages-and-tips
#sudo git clone https://github.com/Hitman007/CRG-Mods.git
sudo git clone https://github.com/JohnDeeBDD/WPbdd.git
sudo git clone https://github.com/JohnDeeBDD/FastRegister.git
sudo git clone https://github.com/JohnDeeBDD/better-error-messages.git
sudo chmod -R 777 /var/www
cd /var/www/html/wp-content/plugins/WPbdd
#composer install
cd /var/www/html/wp-content/plugins/WPbdd/tests
sudo sed -i "s/replaceme.com/$varurl/g" "runner.suite.yml"
sudo sed -i "s/replaceme.com/$varurl/g" "acceptance.suite.yml"

#setup apache conf
sudo mv /var/www/html/wp-content/plugins/WPbdd/apache.txt /etc/apache2/sites-available/000-default.conf

#cleanup:
sudo chmod 777 -R /var/www/html
sudo apt-get clean
#sudo service apache2 restart
sudo reboot
#source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/UbuntuWPFinish.sh)
