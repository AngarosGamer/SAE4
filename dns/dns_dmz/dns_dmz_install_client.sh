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
    ip addr add 192.168.0.4 dev enp1s0
    ip route add default via 192.168.0.4

#ajouter le nom du serveur DNS dans /interfaces
#verification si la ligne "iface enp1s0 inet static" est présente
    if grep 'auto enp1s0' "$interfacesFile"; then
        if grep 'iface enp1s0 inet static' "$interfacesFile"; then
        sed -i 'iface enp1s0 inet static/a    dns-nameservers 192.168.0.4' $interfacesFile
        else
        sed -i '$a\auto enp1s0\niface enp1s0 inet static\n    dns-nameservers 192.168.0.4' $interfacesFile
        fi
    else
        if grep 'iface enp1s0 inet static' "$interfacesFile"; then
        #remplacer la ligne avant 'iface enp1s0 inet static' par 'auto enp1s0'
        sed 'iface enp1s0 inet static/ i\auto enp1s0' $interfacesFile
        sed -i 'iface enp1s0 inet static/a    dns-nameservers 192.168.0.4' $interfacesFile
        #ajouter la ligne 'iface enp1s0 inet static' après 'auto enp1s0'
        else
        #ajouter à la fin du document les lignes suivantes
        cat > $interface << 'EOF'
auto enp1s0
iface enp1s0 inet static
address 192.168.0.4
netmask 255.255.255.0
gateway 192.168.0.0
EOF
echo "recréation du fichier interfaces"
        fi
    fi

#redémarrer le service network
systemctl restart networking.service

