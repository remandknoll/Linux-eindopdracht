#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
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

