#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/wp3.sh)

sudo mysql -u root -ppassword << EOF
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON *.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EOF

sudo mysql -u root -ppassword << EOF
CREATE DATABASE wordpress_unit_test DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON *.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# Wordpress plugins:
#cd /var/www/html/wp-content/plugins
#sudo rm -fr akismet
#sudo rm hello.php
#sudo git clone https://github.com/Hitman007/CRG-Mods.git
#sudo git clone https://github.com/JohnDeeBDD/WPbdd.git
#sudo git clone https://github.com/JohnDeeBDD/FastRegister.git
#sudo git clone https://github.com/JohnDeeBDD/better-error-messages.git
#sudo git clone https://github.com/JohnDeeBDD/external-content-portfolio.git
#sudo chmod -R 777 /var/www
#cd /var/www/html/wp-content/plugins/WPbdd/tests
#sudo replace "replaceme.com" $varurl -- runner.suite.yml
#sudo replace "replaceme.com" $varurl -- acceptance.suite.yml

#cd /var/www/html/wp-content/plugins/external-content-portfolio/tests
#sudo replace "replaceme.com" $varurl -- runner.suite.yml
#sudo replace "replaceme.com" $varurl -- acceptance.suite.yml
#cd ..
#composer install
#cd /var/www/html/wp-content/plugins/WPbdd
#composer install

#setup apache conf
#sudo mv /var/www/html/wp-content/plugins/WPbdd/apacheconf.txt /etc/apache2/sites-available/000-default.conf
#cd /etc/apache2/sites-available/
#sudo replace replaceme.com $varurl -- 000-default.conf

#install phantomJS
#sudo apt-get -y install build-essential chrpath libssl-dev libxft-dev
#sudo apt-get -y install libfreetype6 libfreetype6-dev
#sudo apt-get -y install libfontconfig1 libfontconfig1-dev
#to run phantomjs:
# cd /var/www/html/wp-content/plugins/WPbdd
# ./phantomjs --webdriver=4444
#xvfb-run java -Dwebdriver.chrome.driver=/var/www/html/wp-content/plugins/WPbdd/chromedriver -jar selenium.jar

#install nodeJS
#sudo apt-get -y install nodejs

#cleanup:
#sudo chmod 777 -R /var/www/html
#sudo apt-get clean
#sudo service apache2 restart

#activate WordPress via the Codeception runner and CLI:
#cd /var/www/html/wp-content/plugins/WPbdd
#nohup xvfb-run java -Dwebdriver.chrome.driver=/var/www/html/wp-content/plugins/WPbdd/chromedriver -jar selenium.jar &>/dev/null &
#bin/codecept build
#bin/codecept run runner -vvv --html
#bin/wp theme install responsive-kubrick --activate
#bin/wp plugin activate FastRegister
#bin/wp widget add my_widget sidebar-1 1
#bin/wp rewrite structure '/%postname%/'

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
#sudo service apache2 restart
#nano ~/.ssh/authorized_keys

#cloud9 symbolic link
#ln -s /var/www/html /home/ubuntu
