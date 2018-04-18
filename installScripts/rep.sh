#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/rep.sh)
echo What is the URL of the site?
read varurl
cd /var/www/html/wp-content/plugins/WPbdd/tests
replace "http://replaceme.com" $varurl -- runner.suite.yml
