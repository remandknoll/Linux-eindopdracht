#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#root maken
sudo -i

#install syslog-ng
apt-get install syslog-ng -y
echo "********* SYSLOG-NG IS GEINSTALLEERD HOEZEEE **********" 

#configure /etc/syslog-ng/syslog-ng.conf
sed -i 's/options { chain_hostnames(off);/options { create_dirs(yes); chain_hostnames(off);/g' /etc/syslog-ng/syslog-ng.conf
echo "********* Syslog kan nu directories maken **********"
sed -i 's/#source s_net { tcp(ip(127.0.0.1)/source s_net { tcp(ip(10.5.0.150)/g' /etc/syslog-ng/syslog-ng.conf