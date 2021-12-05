#!/bin/bash

echo "${rds_localhost}" > /tmp/test
export rds_localhost=$(cat /tmp/test)
sudo apt-get update
sudo apt-get -y install wget php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc unzip  nginx
cd /var/www
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo rm -rif html
sudo mkdir html
sudo mv ./wordpress/* html
cd html
sudo cp wp-config-sample.php wp-config.php
sudo sed -ie "s/database_name_here/myrdstestmysql/g" wp-config.php
sudo sed -ie "s/username_here/admin/g" wp-config.php
sudo sed -ie "s/password_here/admin123/g" wp-config.php
sudo sed -ie "s/localhost/$rds_localhost/g" wp-config.php
