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

## Install ldap client
wget https://raw.githubusercontent.com/AngarosGamer/SAE4/main/ldap/ldap_install_client.sh
chmod +x ldap_install_client.sh
source ./ldap_install_client.sh

## Install nfs client
wget https://raw.githubusercontent.com/AngarosGamer/SAE4/main/nfs/nfs_install_client.sh
chmod +x nfs_install_client.sh
source ./nfs_install_client.sh

## Install dns client
wget https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dns/dns_intranet/dns_intranet_install_client.sh
chmod +x dns_intranet_nstall_client.sh
source ./dns_intranet_install_client.sh

## Install dhcp client
wget https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dhcp/dhcp_install_client.sh
chmod +x dhcp_install_client.sh
source ./dhcp_install_client.sh