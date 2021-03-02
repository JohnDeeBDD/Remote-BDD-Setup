#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/wordpress.sh)
# Directions: https://generalchicken.net/bdd-wp-aws/

#chromedriver
#cd /var/www
#sudo wget -y https://chromedriver.storage.googleapis.com/84.0.4147.30/chromedriver_linux64.zip
#unzip -y chromedriver_linux64.zip

clear
echo What is the domain name of the site?
read varurl
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get -y upgrade 
sudo apt-get -y install google-chrome-stable
#sudo apt-get -f install
#sudo apt-get -y install nodejs-legacy
#sudo apt-get -y install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
#sudo apt-get -y install vnc4server

#from https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions
sudo apt install php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl -y
sudo apt-get -y install php-hash php-json php-sodium php-openssl

sudo apt-get install build-essential checkinstall && apt-get build-dep imagemagick -y
sudo apt install -y imagemagick
sudo apt install -y php-imagick

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

# Install Wordpress:
sudo chmod -R 777 /var/www
cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
sudo mv -v /var/www/html/wordpress/* /var/www/html/
sudo rm -fr /var/www/html/wordpress
sudo rm /var/www/html/index.html
sudo rm /var/www/html/latest.tar.gz
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
sudo git clone https://github.com/JohnDeeBDD/FastRegister.git
sudo git clone https://github.com/JohnDeeBDD/better-error-messages.git
sudo git clone https://github.com/JohnDeeBDD/external-content-portfolio.git
sudo chmod -R 777 /var/www
cd /var/www/html/wp-content/plugins/WPbdd/tests
#sudo replace "replaceme.com" $varurl -- runner.suite.yml
sed -i "s/replaceme.com/$varurl/g" "runner.suite.yml"
#sudo replace "replaceme.com" $varurl -- acceptance.suite.yml
sed -i "s/replaceme.com/$varurl/g" "acceptance.suite.yml"

#setup apache conf
sudo mv /var/www/html/wp-content/plugins/WPbdd/apacheconf.txt /etc/apache2/sites-available/000-default.conf
cd /etc/apache2/sites-available/
#sudo replace replaceme.com $varurl -- 000-default.conf
sed -i "s/replaceme.com/$varurl/g" "000-default.conf"

#install nodeJS
#sudo apt-get -y install nodejs

#cleanup:
sudo chmod 777 -R /var/www/html
sudo apt-get clean
sudo service apache2 restart

#activate WordPress via the Codeception runner and CLI:
cd /var/www/html/wp-content/plugins/WPbdd
nohup xvfb-run java -Dwebdriver.chrome.driver=/var/www/html/wp-content/plugins/WPbdd/chromedriver -jar selenium.jar &>/dev/null &
bin/codecept build
bin/codecept run runner -vvv --html
bin/wp theme install responsive-kubrick --activate
bin/wp plugin activate FastRegister
bin/wp widget add my_widget sidebar-1 1
bin/wp rewrite structure '/%postname%/'

#removes password auth
# sudo sed -i -e '/^PasswordAuthentication / s/ .*/ yes/' /etc/ssh/sshd_config
# sudo adduser freelancer --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
# This will actually set the password:
# echo "freelancer:password" | sudo chpasswd
# sudo usermod -aG sudo freelancer

#cloud9
#curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
#curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
#sudo apt-get install -y nodejs
#sudo apt-get install python-minimal
#sudo mkdir ~/cloud9
#sudo ln -s /var/www/html/wp-content/plugins /cloud9
sudo service apache2 restart
#nano ~/.ssh/authorized_keys

#cloud9 symbolic link
ln -s /var/www/html /home/ubuntu
