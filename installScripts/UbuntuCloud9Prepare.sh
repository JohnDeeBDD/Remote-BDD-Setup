#source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/UbuntuCloud9Prepare.sh)
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs
sudo apt-get -y upgrade
sudo apt-get -y update
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
sudo apt-get install -y python2-minimal
sudo mkdir ~/cloud9
