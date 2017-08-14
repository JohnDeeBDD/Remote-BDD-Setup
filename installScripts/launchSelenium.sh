#!/usr/bin/env bash

# source <(curl -s https://raw.githubusercontent.com/Hitman007/Remote-BDD-Setup/master/installScripts/launchSelenium.sh)

cd /var/www/html/wp-content/plugins/WPbdd
java -jar selenium.jar -role hub
