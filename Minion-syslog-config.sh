#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
echo "*.* @10.5.0.157:514" >> /etc/rsyslog.d/50-default.conf
sed -i 's/#cron/cron/g' /etc/rsyslog.d/50-default.conf
service rsyslog restart