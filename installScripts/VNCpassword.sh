#!/bin/sh
#
# source <(curl -s https://raw.githubusercontent.com/Hitman007/Remote-BDD-Setup/master/installScripts/VNCpassword.sh)
# Directions: http://customrayguns.com/wp-bdd-software/
prog=/usr/bin/vncpasswd
mypass="newpass"

/usr/bin/expect <<EOF
spawn "$prog"
expect "Password:"
send "$mypass\r"
expect "Verify:"
send "$mypass\r"
expect eof
exit
EOF
sudo vncserver :1
vncserver -kill :1
