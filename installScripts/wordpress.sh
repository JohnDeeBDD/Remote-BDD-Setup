#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/wordpress.sh)
# Directions: https://generalchicken.net/bdd-wp-aws/
# nano ~/.ssh/authorized_keys

echo What is the domain name of the site?
read varurl
sudo apt -y update
sudo apt -y upgrade
sudo snap install node --classic
sudo mkdir ~/cloud9
sudo apt -y install python3

sudo apt -y install net-tools

# Install PHP 8.1 (current supported version)
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt -y install php8.1
sudo apt install -y php8.1-common php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl

# Install Java 11 (LTS version)
sudo apt -y install openjdk-11-jre openjdk-11-jre-headless
sudo apt -y install git zip unzip php-zip
sudo apt -y install expect
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get -y install lamp-server^
sudo a2enmod rewrite
sudo apt-get -y install php-mbstring
sudo apt-get -y install sendmail



#setup swap on Ubuntu:
#sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
#sudo /sbin/mkswap /var/swap.1
#sudo /sbin/swapon /var/swap.1

# Composer:
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

#Apache2
cd /etc/apache2/sites-available
sudo rm 000-default.conf
sudo wget https://raw.githubusercontent.com/JohnDeeBDD/Remote-BDD-Setup/master/installScripts/000-default.conf
sudo service apache2 restart

# Install Wordpress:

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

sudo wp config create --dbname=wordpress --dbuser=wordpressuser --dbpass=password --allow-root
sudo wp core install --url=http://$varurl --title="GENERALCHICKENSITE" --admin_user=Codeception --admin_password=password --admin_email=codeception@email.com --skip-email --allow-root

#setup PHP to own the WordPress directory:
sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo chmod -R g+w /var/www/html/wp-content/themes

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
#sudo git clone https://github.com/JohnDeeBDD/email-tunnel.git
sudo chmod -R 777 /var/www
#cd /var/www/html/wp-content/plugins/WPbdd
#composer install
#cd /var/www/html/wp-content/plugins/WPbdd/tests
#sudo sed -i "s/replaceme.com/$varurl/g" "runner.suite.yml"
#sudo sed -i "s/replaceme.com/$varurl/g" "acceptance.suite.yml"

cd /var/www/html
wp config set FS_METHOD direct --path=/var/www/html
wp config set WP_DEBUG true --path=/var/www/html
wp rewrite structure '/%postname%/' --path=/var/www/html
wp plugin install classic-editor
wp plugin install classic-widgets
wp plugin activate --all
#wp plugin activate woocommerce
wp option update uploads_use_yearmonth_folders 0 --path=/var/www/html

#cleanup:
sudo chmod 777 -R /var/www/html
sudo apt-get clean

sudo reboot
#source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/UbuntuWPFinish.sh)
