#!/bin/bash
#Verifie que le script est lancé en root
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être lancé en tant que root" 
   exit 1
fi

#Installe des paquets isc-dhcp-server
    apt -y install isc-dhcp-server

#Modifier
    sed -i 's/INTERFACESv4=""/INTERFACESv4="enp1s0"/g' /etc/default/isc-dhcp-server

#Replacer le fichier de configuration par celui present dans le dossier dhcp
    wget https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dhcp/dhcpd.conf
    rm /etc/dhcp/dhcpd.conf
    cp dhcpd.conf /etc/dhcp/dhcpd.conf
    rm dhcpd.conf

#modifier le fichier dhclient.conf pour prendre en compte le serveur dns
    sed -i 's/#prepend domain-name-servers 127.0.0.1;/prepend domain-name-servers 192.168.1.6;/g' /etc/dhcp/dhclient.conf

#Redemarrer le service
    systemctl restart isc-dhcp-server.service

#Ajouter le script au démarrage
    #echo "service udhcpd restart" >> /etc/rc.local