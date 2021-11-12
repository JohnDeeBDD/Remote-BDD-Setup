#!/bin/sh
#
# source <(curl -s https://raw.githubusercontent.com/JohnDeeBDD/Remote-BDD-Setup/master/installScripts/ResetWPdatabases.sh)
# to get public IP on AWS:
# dig +short myip.opendns.com @resolver1.opendns.com
# https://www.php.net/manual/en/function.yaml-parse-file.php

#cd /var/www/html/wp-content/plugins/WPbdd
#nohup xvfb-run java -Dwebdriver.chrome.driver=/var/www/html/wp-content/plugins/WPbdd/chromedriver -jar selenium.jar &>/dev/null &

sudo mysql -u root -ppassword << EOF
DROP DATABASE wordpress;
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL PRIVILEGES ON * . * TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EOF
cd /var/www/html
sudo rm wp-config.php
cd /var/www/html/wp-content/plugins/WPbdd/
bin/codecept run runner SetupWordPressCept.php -vvv
wp rewrite structure '/%postname%/'
wp option update uploads_use_yearmonth_folders 0
