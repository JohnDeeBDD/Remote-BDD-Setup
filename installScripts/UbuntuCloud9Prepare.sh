#source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/UbuntuCloud9Prepare.sh)
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install nodejs
sudo apt-get upgrade && sudo apt-get update
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
sudo apt-get install python-minimal
sudo mkdir ~/cloud9
