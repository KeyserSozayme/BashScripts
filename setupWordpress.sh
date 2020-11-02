#!/bin/bash

cd ~
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install lamp-server^
sudo apt -y install phpmyadmin

cd /tmp
sudo rm /var/www/index.html
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xvf latest.tar.gz wordpress
sudo cp -r wordpress/* /var/www/html

cd /var/www/html
sudo chown -R `whoami`:www-data /var/www/html
chmod -R g+s /var/www/html
find /var/www/html -type d -exec chmod 0755 {} \;
find /var/www/html -type f -exec chmod 0644 {} \;

sudo service apache2 restart

echo '!!!'
echo '!!!'
echo "Make sure to create a user and a database for that user in PHPmyAdmin before running the wordpress installer!"
echo '!!!'
echo '!!!'
read -p "Press ENTER to continue..."
