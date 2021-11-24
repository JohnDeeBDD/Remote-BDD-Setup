# Remote-BDD-Setup

Install script from bash:

source <(curl -s https://raw.githubusercontent.com/JohnDeeBDD/Remote-BDD-Setup/master/installScripts/init.sh)

Setup script for reset server:
cd /var/www/html/wp-content/plugins/WPbdd
nohup xvfb-run java -Dwebdriver.chrome.driver=/var/www/html/wp-content/plugins/WPbdd/chromedriver -jar selenium.jar &>/dev/null &

bin/codecept run runner -vvv
