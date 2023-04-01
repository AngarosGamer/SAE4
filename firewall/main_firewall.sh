#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Faire l'installation de nft si non installé
apt install nftables

# Lancer nftables et le paramétrer pour se lancer quand la machine boot + status
systemctl start nftables
systemctl enable nftables
systemctl status nftables

# Installer le tracker des connexions
apt install conntrack

# Installer le JDK de Java
apt install default-jdk

# Réinitialiser le firewall
source ./firewall_reset

# Règles de forward
source ./firewall_rules_forward

# Règles d'entrée
source ./firewall_rules_input