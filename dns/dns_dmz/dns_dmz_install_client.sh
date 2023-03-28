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

#vérifier les paramètres réseau
    ip addr add 192.168.0.4 dev eth1
    ip route add default via 192.168.0.4

#ajouter le nom du serveur DNS dans /interfaces
#verification si la ligne "iface eth0 inet static" est présente
    if grep 'auto eth1' "$interfacesFile"; then
        if grep 'iface eth1 inet static' "$interfacesFile"; then
        sed -i 'iface eth1 inet static/a    dns-nameservers 192.168.0.4' $interfacesFile
        else
        sed -i '$a\auto eth1\niface eth0 inet static\n    dns-nameservers 192.168.0.4' $interfacesFile
        fi
    else
        if grep 'iface eth1 inet static' "$interfacesFile"; then
        #remplacer la ligne avant 'iface eth0 inet static' par 'auto eth1'
        sed 'iface eth1 inet static/ i\auto eth1' $interfacesFile
        sed -i 'iface eth1 inet static/a    dns-nameservers 192.168.0.4' $interfacesFile
        #ajouter la ligne 'iface eth0 inet static' après 'auto eth1'
        else
        #ajouter à la fin du document les lignes suivantes
        cat > $interface << 'EOF'
        auto eth1
        iface eth1 inet static
        address 192.168.0.4
        netmask 255.255.255.0
        gateway 192.168.0.0
EOF
        fi
    fi

#redémarrer le service network
systemctl restart networking.service

