#!/bin/bash

# Atualizar pacotes
sudo apt update && sudo apt upgrade -y

# Instalar Apache, MariaDB, e PHP com as extensões necessárias
sudo apt install -y apache2 mariadb-server php libapache2-mod-php php-{mysql,xml,ldap,apcu,gd,mbstring,curl,zip,bz2,intl}

# Baixar o GLPI
wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz

# Extrair e mover o GLPI para o diretório do Apache
sudo tar -zxvf glpi-10.0.2.tgz -C /var/www/html

# Ajustar permissões
sudo chown -R www-data:www-data /var/www/html/glpi
sudo chmod -R 755 /var/www/html/glpi

# Criar banco de dados MariaDB
sudo mysql -e "CREATE DATABASE glpidb DEFAULT CHARACTER SET utf8;"
sudo mysql -e "CREATE USER 'glpi'@'localhost' IDENTIFIED BY 'senha_segura';"
sudo mysql -e "GRANT ALL PRIVILEGES ON glpidb.* TO 'glpi'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Reiniciar Apache
sudo systemctl restart apache2
