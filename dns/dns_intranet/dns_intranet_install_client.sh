#!/bin/bash
#Check if the user is root
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être lancé en tant que root" 
   exit 1
fi

#ajouter le nom du serveur DNS dans /hostsname
cat > /etc/network/interfaces << 'EOF'
# This file contain the FQDN of the DNS server
dns.cipher.

EOF

interfacesFile="/etc/network/interfaces"
    if grep 'auto enp1s0' "$interfacesFile"; then
        if ! grep 'iface enp1s0 inet dhcp' "$interfacesFile"; then
        sed -i '$a\auto enp1s0\niface enp1s0 inet dhcp' $interfacesFile
        fi
    else
        if ! grep 'iface enp1s0 inet dhcp' "$interfacesFile"; then
       #recreer le document interfaces
        cat > $interface << 'EOF'
auto lo
iface lo inet loopback

auto enp1s0
iface enp1s0 inet dhcp
EOF
echo "recréation du fichier interfaces"
        fi
    fi

#redémarrer le service network
systemctl restart networking.service


#associer l'adresse IPv4 dans le fichier hosts
#text="127.0.0.1     dns.cipher."
#text2="192.168.0.128    dns.cipher.intra"

#sed -i '2i' "$text" /etc/hosts
