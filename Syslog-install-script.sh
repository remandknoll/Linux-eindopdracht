#COPYRIGHT REMAND KNOL - 339249
#root maken
sudo -i

#install syslog-ng
apt-get install syslog-ng -y

#tail on de logs - dus loggen
sudo tail -f /var/log/syslog

