#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#Configuratie aan de hand van: https://www.balabit.com/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/configure-servers.html
#root maken als nodig
sudo -i

#install salt-master + confirm alles
echo "*********** INSTALLING SALT-MASTER BITCHES ***********"
sudo apt-get install salt-master -y

#install salt-minion + confirm alles
echo "*********** INSTALLING SALT-MINION BITCHES ***********"
sudo apt-get install salt-minion -y

#CONFIG
#Configure master file
echo "*********** Effe config goed doen, ok. ***********"
sed -i 's/#interface: 0.0.0.0/interface: 10.5.0.157/g' /etc/salt/master
salt-key --accept-all -y
echo "*********** Alle keys zijn geaccepteerd ***********"
echo "*********** Onderstaande accepted keys  ***********"
salt-key -L