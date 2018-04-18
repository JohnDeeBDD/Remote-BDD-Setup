#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/addUbuntuAdmin.sh)
echo Add a user?
read USR
echo Password?
read PASS
adduser $USR
# This will actually set the password:
echo "$USR:$PASS" | chpasswd
adduser $USR
usermod -aG sudo $USR
