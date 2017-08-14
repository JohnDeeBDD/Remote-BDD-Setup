#!/usr/bin/env bash

# source <(curl -s https://raw.githubusercontent.com/Hitman007/Remote-BDD-Setup/master/installScripts/launchChromedriver.sh)

cd /var/www/html/wp-content/plugins/WPbdd
./chromedriver --url-base=/wd/hub
