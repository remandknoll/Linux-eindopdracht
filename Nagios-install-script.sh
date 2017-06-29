#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#install met behulp van handleiding: https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source.html#Ubuntu
#root maken
sudo -i

#source downloaden
cd /tmp
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.3.2.tar.gz
tar xzf nagioscore.tar.gz

#compilen van gedownloade source
cd /tmp/nagioscore-nagios-4.3.2/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all

#usermaken en binary
useradd nagios
usermod -a -G nagios www-data
make install

#install service
make install-init
update-rc.d nagios defaults
make install-commandmode
make install-config

#apache config install
make install-webconf
a2enmod rewrite
a2enmod cgi

#configure firewall
ufw allow Apache
ufw reload

#make useraccount + pass for apache
htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin admin

#restart apache
service apache2 restart

#start nagios 
service nagios start

#add host minion's in config
cd
mkdir /usr/local/nagios/etc/servers/
cd /usr/local/nagios/etc/servers/
touch ubuntu_host.cfg
echo "# Ubuntu Host configuration file

define host {
        use                          linux-server
        host_name                    minion1
        alias                        Ubuntu Host
        address                      145.37.234.138
        register                     1
}

define service {
      host_name                       minion1
      service_description             PING
      check_command                   check_ping!100.0,20%!500.0,60%
      max_check_attempts              2
      check_interval                  2
      retry_interval                  2
      check_period                    24x7
      check_freshness                 1
      contact_groups                  admins
      notification_interval           2
      notification_period             24x7
      notifications_enabled           1
      register                        1
}

define service {
      host_name                       minion1
      service_description             Check Users
      check_command           check_local_users!20!50
      max_check_attempts              2
      check_interval                  2
      retry_interval                  2
      check_period                    24x7
      check_freshness                 1
      contact_groups                  admins
      notification_interval           2
      notification_period             24x7
      notifications_enabled           1
      register                        1
}

define service {
      host_name                       minion1
      service_description             Local Disk
      check_command                   check_local_disk!20%!10%!/
      max_check_attempts              2
      check_interval                  2
      retry_interval                  2
      check_period                    24x7
      check_freshness                 1
      contact_groups                  admins
      notification_interval           2
      notification_period             24x7
      notifications_enabled           1
      register                        1
}

define service {
      host_name                       minion1
      service_description             Check SSH
      check_command                   check_ssh
      max_check_attempts              2
      check_interval                  2
      retry_interval                  2
      check_period                    24x7
      check_freshness                 1
      contact_groups                  admins
      notification_interval           2
      notification_period             24x7
      notifications_enabled           1
      register                        1
}

define service {
      host_name                       minion1
      service_description             Total Process
      check_command                   check_local_procs!250!400!RSZDT
      max_check_attempts              2
      check_interval                  2
      retry_interval                  2
      check_period                    24x7
      check_freshness                 1
      contact_groups                  admins
      notification_interval           2
      notification_period             24x7
      notifications_enabled           1
      register                        1
}" >> /usr/local/nagios/etc/servers/ubuntu_host.cfg