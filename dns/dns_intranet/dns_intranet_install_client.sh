#!/bin/bash
#Check if the user is root
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être lancé en tant que root" 
   exit 1
fi

#install bind9 packages

#apt -y update
#apt -y install bind9

#verify if bind9 is installed
if ! which bind9 > /dev/null; then
   echo -e "bind9 packages not installed, please advise your system administrator".
fi

#ajouter le nom du serveur DNS dans /hostsname
 cat > /etc/network/interfaces << 'EOL'
   # This file contain the FQDN of the DNS server
   dns.cipher.intra

EOL

#associer l'adresse IPv4 dans le fichier hosts
text="127.0.0.1     dns.cipher.intra"
#text2="192.168.0.128    dns.cipher.intra"

sed -i '2i' "$text" /etc/hosts
