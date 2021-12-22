#!/bin/sh
#
# cd /var/www/html/wp-content/plugins/WPbdd
# nohup xvfb-run java -Dwebdriver.chrome.driver=/var/www/html/wp-content/plugins/WPbdd/chromedriver -jar selenium.jar &>/dev/null &
# source <(curl -s https://raw.githubusercontent.com/JohnDeeBDD/Remote-BDD-Setup/master/installScripts/ResetWPdatabases.sh)
# to get public IP on AWS:
# dig +short myip.opendns.com @resolver1.opendns.com

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
wp user create Subcriberman subscriberman@email.com --role=subscriber --user_pass=password --display_name=Subscriberman
wp plugin activate better-error-messages
wp plugin activate fcfs-block
wp plugin activate disable-administration-email-verification-prompt
wp plugin activate disable-welcome-messages-and-tips
wp plugin activate email-log
wp post delete 1 --force
cd /var/www/html/wp-content/plugins/WPbdd/tests/runner
php ChangeYmlIPs.php
cd /var/www/html/wp-content/plugins/fcfs-block
