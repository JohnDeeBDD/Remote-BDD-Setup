#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/installplugin.sh)
#
clear
echo What is the domain name of the site?
read varurl
clear
echo What is the git clone URL?
read vargit
clear
echo What is the directory name?
read vardir
cd /var/www/html/wp-content/plugins
sudo git clone $vargit
sudo chmod -R 777 $vardir
cd $vardir
composer install
cd tests
sudo replace "replaceme.com" $varurl -- acceptance.suite.yml
cd ..
