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
sed -i 's/#interface: 0.0.0.0/interface: 10.0.0.1/g' /etc/salt/master


