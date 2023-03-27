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

#Téléchargement et execution des scripts devant être présent sur les postes de travail
#wget "https://raw.githubusercontent.com/AngarosGamer/SAE4/main/ldap/ldap_install_client"
#chmod +x ldap_install_client
#source ldap_install_client

#wget "https://raw.githubusercontent.com/AngarosGamer/SAE4/main/nfs/nfs_install_client"
#chmod +x nfs_install_client
#source nfs_install_client

