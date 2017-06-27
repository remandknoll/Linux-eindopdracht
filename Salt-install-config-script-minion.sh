#root maken als nodig
sudo -i

#install salt-master + confirm alles
echo "*********** INSTALLING SALT-MASTER BITCHES ***********"
sudo apt-get install salt-master -y

#install salt-minion + confirm alles
echo "*********** INSTALLING SALT-MINION BITCHES ***********"
sudo apt-get install salt-minion -y

#CONFIG
#Configure minion file
echo "*********** Effe configs goed doen, ok. ***********"
sed -i 's/#master: salt/master: 10.0.0.1/g' /etc/salt/minion
service salt-minion restart
