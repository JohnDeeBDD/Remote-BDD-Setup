#!/bin/sh
#
# source <(curl -s https://raw.githubusercontent.com/JohnDeeBDD/Remote-BDD-Setup/master/installScripts/ResetWPdatabases.sh)

sudo mysql -u root -ppassword << EOF
DROP DATABASE wordpress;
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF
