#!/bin/bash

echo
echo Gesture Controller Installation
echo
echo "Requeriments:"
echo " * SSH"
echo " * NodeJs (>= 10.x)"
echo " * npm (>= 4.x)"
echo
echo [PRESS ENTER TO CONTINUE]
read
cd gcserver
npm install
echo Installation finished...
echo
echo
echo -n "Server port (8080):"
read SERVER_PORT
echo -n "Master IP (localhost):"
read MASTER_IP
if [ -z $MASTER_IP ] || [ $MASTER_IP = 'localhost' ]; then
  MASTER_IP='localhost'
fi
echo -n "" > .env
echo SERVER_PORT=$SERVER_PORT >> .env
echo MASTER_IP=$MASTER_IP >> .env

sudo iptables -I INPUT 1 -i eth0 -p tcp --dport $SERVER_PORT -j ACCEPT
sudo iptables-save

# ssh-keygen -f /tmp/gcserver -t rsa -b 4096 -q -N "" -C "$SUDO_USER@$HOSTNAME"
# ssh-keygen -t rsa -f gcserver

if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -q -N ""
fi
sudo cat ~/.ssh/id_rsa.pub | ssh lg@$MASTER_IP 'cat >> .ssh/authorized_keys'
