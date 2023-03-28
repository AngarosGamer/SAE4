#!/bin/bash
#Verfie si le script est lancé en tant que root
: <<COMMENT
    if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être lancé en tant que root" 
    exit 1
    fi

#installe les packages bind9

    apt install bind9

#verifie si bind9 est installé
    if ! which bind9 > /dev/null; then
    echo -e "bind9 packages not installed, please advise your system administrator".
    fi

COMMENT

fileNamedConf="/users/info/etu-2a/boussitt/SAE4/test.txt"
fileNamedConfLocal="/users/info/etu-2a/boussitt/SAE4/a.conf.local"

#NAME.CONF


#ajouter le nom du serveur DNS dans /hostsname
# cat > /etc/network/interfaces << 'EOL'
   # This fileNamedConf contain the FQDN of the DNS server
 #  dns.cipher.intra

#EOL

#gerer les options dans le fichier namded.conf
    
    #verifier lesquelles sont présentes et eviter les doublons
    #verifier si la ligne "directory" est présente
    if grep -q 'directory' "$fileNamedConf"; then
    sed -i '/directory/d' "$fileNamedConf"
    fi

    #verifier si la ligne "recursion no;" est présente
    if grep -q 'recursion no;' "$fileNamedConf"; then
    sed -i '/recursion no/d' "$fileNamedConf"
    fi
    
    #verifier si la ligne "allow-query {" est présente
    if grep -q 'allow-transfer' "$fileNamedConf"; then
    sed -i '/allow-transfer/d' "$fileNamedConf"
    fi
    
    #verifier si la ligne "allow-query {" est présente
    if grep -q 'allow-query {' "$fileNamedConf"; then
    sed -i '/allow-query {/d' "$fileNamedConf"
    fi

    #verifier si la ligne "allow-query-cache {" est présente
    if grep -q 'allow-query-cache {' "$fileNamedConf"; then
    sed -i '/allow-query-cache {/d' "$fileNamedConf"
    fi

    #verifier si la ligne "allow-recursion {" est présente
    if grep 'allow-recursion {' "$fileNamedConf"; then
    sed -i '/allow-recursion {/d' "$fileNamedConf"
    fi

    #verifier si la ligne "forwarders{" est présente
    if grep 'forwarders{' "$fileNamedConf"; then
    sed -i '/forwarders{/d' "$fileNamedConf"
    fi

    #verifier si la ligne "dnssec-validation" est présente
    if grep 'dnssec-validation' "$fileNamedConf"; then
    sed -i '/dnssec-validation/d' "$fileNamedConf"
    fi

    #verifier si la ligne "auth-nxdomain" est présente
    if grep 'auth-nxdomain' "$fileNamedConf"; then
    sed -i '/auth-nxdomain/d' "$fileNamedConf"
    fi

    #verifier si la ligne "options {" est présente
    if ! grep 'options {' "$fileNamedConf"; then
    sed -i '$a\options {\n};' "$fileNamedConf"
    echo 'options'
    cat "$fileNamedConf"
    fi

    #verifier si des lignes "};" sont présentes
    if grep '};' "$fileNamedConf"; then
    sed -i '/};/d' "$fileNamedConf"
    fi

    #gerer les options dans le fichier namded.conf
    sed -i '/options {/a directory "/var/cache/bind";\nallow-transfer { none; } \nallow-query {any;};\nallow-query-cache{any;};\nallow-recursion {localnets;};\nforwarders{\n};\ndnssec-validation auto;\nauth-nxdomain no;\n' "$fileNamedConf"

#creer la zone de l'intranet

    sed -i '$a\// Define the DMZ zone\nzone "dmz.example.com" {\n    type master;\n    fileNamedConf "/etc/bind/zones/dmz.cipher.com";\n};' "$fileNamedConf"


#vérifier si la ligne "include named.conf.local" est présente
    if grep "include "$fileNamedConfLocal";" $fileNamedConf; then
        echo "is(are) present"
    else
        echo "include named.conf.local is added to the fileNamedConf"
        #ajouter à la fin du fichier le include "etc/bind/named.conf.local"
        sed -i '$a\include "/etc/bind/named.conf.local";' $fileNamedConf
        echo "added"
    fi

#NAMED.CONF.LOCAL

#overwriting de named.conf.local
    rm $fileNamedConfLocal
    cp dmzNamed.conf.local $fileNamedConfLocal