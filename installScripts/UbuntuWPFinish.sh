#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/UbuntuWPFinish.sh)
# Directions: https://generalchicken.net/bdd-wp-aws/

#activate WordPress via the Codeception runner and CLI. Assumes Selenium is running:
cd /var/www/html/wp-content/plugins/WPbdd
bin/codecept run runner -vvv --html
wp theme install responsive-kubrick --activate
wp plugin activate FastRegister
wp widget add my_widget sidebar-1 1
wp rewrite structure '/%postname%/'

cd /var/www/html
sudo sed -i "s/( 'WP_DEBUG', false )/( 'WP_DEBUG', true )/g" "wp-config.php"

#removes password auth
# sudo sed -i -e '/^PasswordAuthentication / s/ .*/ yes/' /etc/ssh/sshd_config
# sudo adduser freelancer --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
# This will actually set the password:
# echo "freelancer:password" | sudo chpasswd
# sudo usermod -aG sudo freelancer

sudo service apache2 restart

#cloud9 symbolic link
ln -s /var/www/html /home/ubuntu
