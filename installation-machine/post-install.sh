#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

read -rp 'Nom de la machine [défaut: cipher]:' hostname

hostnamectl set-hostname "$hostname"

read -rp 'Utilisateur par défaut: ' username

adduser "$username"
userdel -r setupaccount

echo "Modification du mot de passe root. Choisissez un mot de passe suffisement complexe"

passwd

apt install -y zabbix-agent
sed -i 's/Server=127.0.0.1/Server=192.168.1.10/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive=127.0.0.1/ServerActive=192.168.1.10/g' /etc/zabbix/zabbix_agentd.conf

systemctl enable zabbix-agent
systemctl restart zabbix-agent