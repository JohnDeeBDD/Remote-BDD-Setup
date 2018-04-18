#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/addUbuntuAdmin.sh)
clear
echo Add a user?
read USR
echo Password?
read PASS
sudo adduser $USR --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
# This will actually set the password:
echo "$USR:$PASS" | sudo chpasswd
sudo usermod -aG sudo $USR
