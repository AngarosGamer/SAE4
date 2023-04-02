#!/bin/bash

if [ "$#" -ne 1 ];
then
  echo "Il faut renseigner l'addresse ip de la machine cliente"
	echo "Exemple de commande :"
	echo "./nfs_add_client 192.168.2.4"
fi
# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Mise en place du service NFS pour les homedirs de la machine d'addresse passée en parametre
"/home $1(rw,async,no_subtree_check)" >> /etc/exports

# Relancer le serveur NFS
systemctl restart nfs-kernel-server