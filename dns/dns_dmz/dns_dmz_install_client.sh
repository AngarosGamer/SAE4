#!/bin/bash

#Verfie si le script est lancé en tant que root
    if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être lancé en tant qui root" 
    exit 1
    fi

resolvFile="/etc/resolv.conf"
interfacesFile="/etc/network/interfaces"
#modifier le fichier /etc/resolv.conf
sed -i '$a\//adresse IP primaire du dns de la dmz' $resolvFile
sed -i '$a\nameserver 192.168.0.4' $resolvFile

#ajouter le nom du serveur DNS dans /interfaces
#verification si la ligne "iface eth0 inet static" est présente
    if grep 'iface eth0 inet static' "$interfacesFile"; then
    sed -i 'iface eth0 inet static/a    dns-nameservers 192.168.0.4' $interfacesFile
    else
    sed -i '$a\iface eth0 inet static\n    dns-nameservers 192.168.0.4' $interfacesFile
    fi

#redémarrer le service network
systemctl restart networking.service

