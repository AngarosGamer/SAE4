#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Installation d'apache2
apt update
apt -y install apache2 curl

# Installation de PHP8.2
curl -sSL https://packages.sury.org/php/README.txt | bash -x
apt update

# Mise en place des fichiers de l'intranet dans le répertoire du serveur web
wget https://github.com/AngarosGamer/SAE4/tree/main/intranet -P /var/www/html/

# Mise en marche de apache
systemctl restart apache2
systemctl enable apache2
systemctl status apache2