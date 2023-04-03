#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi
if [[ "$#" -ne 1 ]];
then
    echo "Il faut renseigner l'adresse IP du serveur de fichier où NFS ira chercher les répertoire"
    echo "Exemple de commande :"
	echo "./nfs_install_client 192.168.1.5 "
else

# Installer le client NFS sur la machine
apt -y install nfs-common

# Monter le homedir dans le serveur NFS
mount $1:/home /home
ls /home

echo "$1:/home   /home   nfs  noauto,x-systemd.automount   0  0" >> /etc/fstab
