#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Installer les packages utiles à postgres
apt update && sudo apt upgrade
apt install postgresql postgresql-contrib

# Vérifier l'état de postgres et le mettre en place à chaque lancement
systemctl start postgresql
systemctl enable postgresql
systemctl status postgresql