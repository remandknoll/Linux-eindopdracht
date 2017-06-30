#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#install met behulp van handleiding: https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source.html#Ubuntu
#root maken
sudo -i

sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.0 libgd2-xpm-dev
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
touch /usr/local/nagios/etc/objects/minion1_host.cfg
echo "# Define a host for the local machine

define host{
        use                     linux-server            ; Name of host template to use
                                                        ; This host definition will inherit all variables that are defined
                                                        ; in (or inherited by) the linux-server host template definition.
        host_name               ubuntu_minion1
        alias                   google.com
        address                 145.37.234.138
        }

###############################################################################
###############################################################################
#
# SERVICE DEFINITIONS
#
###############################################################################
###############################################################################

# Define a service to ping the local machine

define service{
        use                             generic-service         ; Name of service template to use
        host_name                       ubuntu_minion1
        service_description             PING
        check_command                   check_ping!100.0,20%!500.0,60%
        }

# Define a service to check HTTP on the local machine.
# Disable notifications for this service by default, as not all users may have HTTP enabled.

define service{
        use                             generic-service         ; Name of service template to use
        host_name                       ubuntu_minion1
        service_description             HTTP
        check_command                   check_http
        notifications_enabled           0
        }" >> /usr/local/nagios/etc/servers/minion1_host.cfg

#config aanpassen zodat admin rechten heb
#sed -i 's/authorized_for_configuration_information=nagiosadmin/authorized_for_configuration_information=*/g' /usr/local/nagios/etc/cgi.cfg
#sed -i 's/authorized_for_system_information=nagiosadmin/authorized_for_system_information=*/g' /usr/local/nagios/etc/cgi.cfg
#sed -i 's/authorized_for_system_commands=nagiosadmin/authorized_for_system_commands=*/g' /usr/local/nagios/etc/cgi.cfg
#sed -i 's/authorized_for_all_hosts=nagiosadmin/authorized_for_all_hosts=*/g' /usr/local/nagios/etc/cgi.cfg
#sed -i 's/authorized_for_all_services=nagiosadmin/authorized_for_all_services=*/g' /usr/local/nagios/etc/cgi.cfg
echo "cfg_file=/usr/local/nagios/etc/servers/minion1_host.cfg" >> /usr/local/nagios/etc/nagios.cfg
#nog ff restarten
service apache2 restart
service nagios restart