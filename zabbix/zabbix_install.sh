#!/bin/bash

# /!\ Il faut environ 3Go d'espace disponible pour installer Zabbix

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

ip=$(hostname -I)

# Installer le répertoire Zabbix
wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb
dpkg -i zabbix-release_6.4-1+debian11_all.deb
apt update

# Installer le serveur Zabbix, frontend, et l'agent
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y

# Installer la base de données MariaDB (fork de MySQL)
apt -y install mariadb-server

# Lancer le processus MariaDB maintenant et quand la machine boot - vérifier son état
systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb

# Changer le mot de passe root de MariaDB et la sécuriser
mysql_secure_installation

# Creer la base de données
read -srp 'Mot de passe pour la base de données [défaut: rootDBpass]:' dbPassword

#mysql -uroot -p"$dbPassword" -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
#mysql -uroot -p"$dbPassword" -e "grant all privileges on zabbix.* to zabbix@localhost identified by ${dbPassword};"

read -rp "Remplissez les conditions d'installation définies dans la documentation avant de continuer ! (Appuyez sur une touche pour continuer)" 

# Importer les tables et valeurs par défaut dans la base de données
echo "Attention! La commande suivante peut prendre du temps (5 minutes). Ne quittez pas l'installation!"
zcat  /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -u zabbix -p"$dbPassword" zabbix

# Entrer dans la base de données et modifier les valeurs de mot de passe
"DBPassword=$dbPassword" >> /etc/zabbix/zabbix_server.conf


# Lancer le serveur Zabbix et son processus agent - Vérifier son état
systemctl restart zabbix-server zabbix-agent
systemctl enable zabbix-server zabbix-agent
systemctl status zabbix-server zabbix-agent

# Lancer le processus Apache2
systemctl restart apache2
systemctl enable apache2
systemctl status apache2

echo "Installation terminée!"
echo "L'interface de configuration est accessible sur http://$ip/zabbix"
echo ""
echo "Afin de compléter l'installation, allez sur ce site, et entrez les informations demandées (ne pas oublier le mot de passe de la base de données)"
echo ""
echo "Une fois terminé, pour vous connecter, utilisez les identifiants suivants:"
echo "Utilisateur: Admin"
echo "Mot de passe: zabbix"