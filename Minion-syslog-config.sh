#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#config remote control aan de hand van: http://www.randomhacks.co.uk/how-to-configure-an-ubuntu-server-to-log-to-a-remote-syslog-server/
echo "*.* @10.5.0.157:514" >> /etc/rsyslog.d/50-default.conf
service rsyslog restart