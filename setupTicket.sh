#!/bin/bash

cd ~
sudo add-apt-repository -y ppa:ondrej/php
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install lamp-server^
sudo apt -y purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`
sudo apt -y install php5.6 php5.6-cli php5.6-mysql php-gettext php5.6-mbstring php-xdebug libapache2-mod-php5.6 php5.6-gd php5.6-imap php5.6-xml unzip openssh-server
sudo apt -y install phpmyadmin

sudo ln -fs /usr/share/phpmyadmin /var/www/phpmyadmin

sudo sed -i '23s:.*:        php_admin_value open_basedir "none":' /etc/phpmyadmin/apache.conf
sudo service apache2 restart

mysql -u root -pP@ssw0rd << EOF
CREATE USER 'osticketuser'@'localhost' IDENTIFIED WITH mysql_native_password AS 'P@ssw0rd';
GRANT ALL PRIVILEGES ON *.* TO 'osticketuser'@'localhost' REQUIRE NONE WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
CREATE DATABASE IF NOT EXISTS `osticketuser`;
GRANT ALL PRIVILEGES ON `osticketuser`.* TO 'osticketuser'@'localhost';
GRANT ALL PRIVILEGES ON `osticketuser\_%`.* TO 'osticketuser'@'localhost';
EOF

cd /tmp
sudo wget http://osticket.com/sites/default/files/download/osTicket-v1.10.zip
sudo unzip osTicket* -d ticket
sudo cp -r ticket/upload/* /var/www/html
sudo chown -R administrator:www-data /var/www/html

cd /var/www/html
cp include/ost-sampleconfig.php include/ost-config.php
mv /var/www/html/index.html /var/www/html/index.html.orig
chmod -R g+s /var/www/html
find /var/www/html -type d -exec chmod 0755 {} \;
find /var/www/html -type f -exec chmod 0644 {} \;
chmod 0666 include/ost-config.php