#!/bin/sh
#
# source <(curl -s https://raw.githubusercontent.com/Hitman007/Remote-BDD-Setup/master/installScripts/ResetWPdatabases.sh)

sudo mysql -u root -pKarlinski123$ << EOF
DROP DATABASE wordprees_unit_test;
CREATE DATABASE wordprees_unit_test DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON wordprees_unit_test.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF
