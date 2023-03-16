#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Installation du serveur NFS sur la machine serveur du système de fichiers
apt update
apt -y install nfs-kernel-server


# Relancer le serveur NFS
systemctl restart nfs-kernel-server

# Activer et demarrer le service nfs
systemctl enable --now nfs-server.service

# Vérifier les exports NFS
exportfs 