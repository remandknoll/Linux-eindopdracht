#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#Configuratie aan de hand van: https://www.balabit.com/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/configure-servers.html
#root maken als nodig
sudo -i

#install salt-minion + confirm alles
echo "*********** INSTALLING SALT-MINION BITCHES ***********"
sudo apt-get install salt-minion -y

#CONFIG
#Configure minion file
echo "*********** Effe configs goed doen, ok. ***********"
sed -i 's/#master: salt/master: 10.5.0.157/g' /etc/salt/minion
service salt-minion restart
echo "*********** Salt-minion service ge-restart ***********"
