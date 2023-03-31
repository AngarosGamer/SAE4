#!/bin/bash

#Lancer ce script en root
#Si l'utilisateur lancant le script n'est pas root, cela affichera un message d'erreur 
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être lancé en tant que root" 
   exit 1
fi

if ! dpkg -s isc-dhcp-client > /dev/null 2>&1
then
   echo "Installation du paquet isc-dhcp-client"
   apt -y install isc-dhcp-client
fi

#reecrire le fichier interfaces
cat > /etc/network/interfaces << 'EOF'
auto lo
iface lo inet loopback

auto enp1s0
iface enp1s0 inet dhcp
EOF


#Redémarrage du service networking
systemctl restart networking.service