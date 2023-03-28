#!/bin/bash

#Verfie si le script est lancé en tant que root
    if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être lancé en tant que root" 
    exit 1
    fi

resolvFile="/etc/resolv.conf"
interfacesFile="/etc/network/interfaces"
#modifier le fichier /etc/resolv.conf
sed -i '$a\nameserver 192.168.150.4' $resolvFile

#ajouter le nom du serveur DNS dans /interfaces
sed -i '$a\dns-servername 192.168.150.4' $interfacesFile

#redémarrer le service network
systemctl restart networking.service