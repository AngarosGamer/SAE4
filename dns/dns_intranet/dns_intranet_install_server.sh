#!/bin/bash
#Check if the user is root
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être lancé en tant que root" 
   exit 1
fi

#install bind9 packages

apt install bind9

#verify if bind9 is installed
if ! which bind9 > /dev/null; then
   echo -e "bind9 packages not installed, please advise your system administrator".
fi

#ajouter le nom du serveur DNS dans /hostsname
# cat > /etc/network/interfaces << 'EOL'
   # This file contain the FQDN of the DNS server
 #  dns.cipher.intra

#EOL

#creer la zone de l'intranet
cat > /etc/named.conf << 'EOL'
// Define the local network zone
zone "intra.cipher.com" {
    type master;
    file "/etc/bind/zones/intra.cipher.com";
    allow-transfer { key "transfer-key"; };
};

// Define a reverse lookup zone for the local network
zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.168.1";
    allow-transfer { key "transfer-key"; };
};
EOL