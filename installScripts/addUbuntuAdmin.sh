#!/bin/sh
#
# you may have to install curl first with: sudo apt-get install curl
# source <(curl -s https://raw.githubusercontent.com/johndeebdd/Remote-BDD-Setup/master/installScripts/addUbuntuAdmin.sh)
clear
#removes password auth
sudo sed -i -e '/^PasswordAuthentication / s/ .*/ yes/' /etc/ssh/sshd_config
sudo adduser freelancer --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
# This will actually set the password:
echo "freelancer:password" | sudo chpasswd
sudo usermod -aG sudo freelancer
