#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#install met behulp van handleiding: https://www.howtoforge.com/tutorial/ubuntu-nagios/
#root maken
sudo -i

#install nagios plugin
apt-get install nagios-nrpe-server nagios-plugins -y

#edit config naar eigen ip
sed -i 's/#server_address=127.0.0.1/server_address=145.37.234.184/g' /etc/nagios/nrpe.cfg
service nagios-nrpe-server restart