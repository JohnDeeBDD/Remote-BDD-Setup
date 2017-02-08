#!/bin/sh
cd /var
#sudo chmod -R 777 /var/www
#sudo rm -fr /var/www
#sudo git clone https://github.com/Hitman007/Remote-BDD-Setup.git
#sudo mv /var/Remote-BDD-Setup /var/www
#sudo chmod -R 777 /var/www
sudo mv /var/www/installScripts/apache2.conf /etc/apache2/apache2.conf
sudo mv /var/www/installScripts/xstartup ~/.vnc/xstartup
cd /var/www/html/wp-content/plugins
sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo rm -fr akismet
sudo rm hello.php
sudo git clone https://github.com/Hitman007/Wordpress-Pickles.git
sudo git clone https://Hitman007@bitbucket.org/Hitman007/crg_mods.git
sudo reboot
