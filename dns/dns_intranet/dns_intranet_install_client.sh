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
        if grep 'iface enp1s0 inet dhcp' "$interfacesFile"; then
        sed -i 'iface enp1s0 inet dhcp/a    dns-nameservers 192.168.0.4' $interfacesFile
        else
        sed -i '$a\auto enp1s0\niface enp1s0 inet dhcp\n    dns-nameservers 192.168.0.4' $interfacesFile
        fi
    else
        if grep 'iface enp1s0 inet dhcp' "$interfacesFile"; then
        #remplacer la ligne avant 'iface enp1s0 inet static' par 'auto enp1s0'
        sed 'iface enp1s0 inet dhcp/ i\auto enp1s0' $interfacesFile
        sed -i 'iface enp1s0 inet dhcp/a    dns-nameservers 192.168.0.4' $interfacesFile
        #ajouter la ligne 'iface enp1s0 inet static' après 'auto enp1s0'
        else
        #ajouter à la fin du document les lignes suivantes
        cat > $interface << 'EOF'
auto enp1s0
iface enp1s0 inet dhcp
address 192.168.0.4
netmask 255.255.255.0
gateway 192.168.0.0
EOF
echo "recréation du fichier interfaces"
        fi
    fi


#associer l'adresse IPv4 dans le fichier hosts
text="127.0.0.1     dns.cipher."
#text2="192.168.0.128    dns.cipher.intra"

sed -i '2i' "$text" /etc/hosts
