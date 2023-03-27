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

#gerer les options dans le fichier namded.conf
    file="/etc/named.conf"
    #verifier lesquelles sont présentes et eviter les doublons
    #verifier si la ligne "recursion no;" est présente
    if grep 'recursion no;' $file; then
    sed -i '/options {/a\recursion no;/d' $file
    fi
    #verifier si la ligne "allow-query {any;};\n" est présente
    if grep 'allow-transfer { none; }' $file; then
    sed -i '/allow-transfer { none; };\n/d' $file
    fi

    #verifier si la ligne "allow-query {any;};\n" est présente
    if grep 'allow-query {any;};' $file; then
    sed -i '/options {/a\allow-query {any;};\n/d' $file
    fi

    #verifier si la ligne "allow-query-cache{any;};\n" est présente
    if grep 'allow-query-cache{any;};' $file; then
    sed -i '/options {/a\allow-query-cache{any;};\n/d' $file
    fi

    #verifier si la ligne "allow-recursion {localnets;};\n" est présente
    if grep 'allow-recursion {localnets;};' $file; then
    sed -i '/options {/a\allow-recursion {localnets;};\n/d' $file
    fi

    #verifier si la ligne "forwarders{};\n" est présente
    if grep 'forwarders{};' $file; then
    sed -i '/options {/a\forwarders{};\n/d' $file
    fi

    #verifier si la ligne "dnssec-validation auto;\n" est présente
    if grep 'dnssec-validation auto;' $file; then
    sed -i '/options {/a\dnssec-validation auto;\n/d' $file
    fi

    #verifier si la ligne "auth-nxdomain no;\n};' /etc/named.conf" est présente
    if grep 'auth-nxdomain no;' $file; then
    sed -i '/options {/a\auth-nxdomain no;\n}/d;' $file
    fi

    #verifier si la ligne "options {" est présente
    if ! grep 'options {' $file; then
    sed -i '/options {\n}/d' $file
    fi

    #gerer les options dans le fichier namded.conf
    sed -i '/options {/a\allow-transfer { none; };\n
    allow-query {any;};\n
    allow-query-cache{any;};\n
    allow-recursion {localnets;};\n
    forwarders{};\n
    dnssec-validation auto;\n
    auth-nxdomain no;\n};' $file

#creer la zone de l'intranet
    cat > /etc/named.conf << 'EOL'
    // Define the DMZ zone
    zone "dmz.example.com" {
        type master;
        file "/etc/bind/zones/dmz.cipher.com";
    };
    EOL





#vérifier si la ligne "include named.conf.local" est présente
if grep 'include "/etc/bind/named.conf.local";' /etc/named.conf; then
    echo "is(are) present"
else
    echo "include named.conf.local is added to the file"
    #ajouter à la fin du fichier le include "etc/bind/named.conf.local"
    sed -i '$a\include "/etc/bind/named.conf.local";' /etc/named.conf
    echo "added"
fi