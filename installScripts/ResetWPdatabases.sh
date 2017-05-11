#!/bin/sh
#
# source <(curl -s https://raw.githubusercontent.com/Hitman007/Remote-BDD-Setup/master/installScripts/ResetWPdatabases.sh)

mysql -u root -ppassword << EOF
#DROP DATABASE wordpress;
DROP DATABASE wordprees_unit_test;
#CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE DATABASE wordprees_unit_test DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
#GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON wordprees_unit_test.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF
