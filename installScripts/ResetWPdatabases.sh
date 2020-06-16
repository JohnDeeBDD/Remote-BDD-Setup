#!/bin/sh
#
# source <(curl -s https://raw.githubusercontent.com/JohnDeeBDD/Remote-BDD-Setup/master/installScripts/ResetWPdatabases.sh)

sudo mysql -u root -ppassword << EOF
DROP DATABASE wordpress;
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF
sudo rm /var/www/html/wp-config.php
cd /var/www/html/wp-content/plugins/migrate-posts/
bin/codecept run tools -vvv
cd /var/www/html/wp-content/plugins/migrate-posts/
sudo bin/wp rewrite structure '/%postname%/'
