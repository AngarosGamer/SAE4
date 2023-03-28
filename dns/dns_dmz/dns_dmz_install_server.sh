#!/bin/bash
#Verfie si le script est lancé en tant que root
    if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être lancé en tant que root" 
    exit 1
    fi

#installe les packages bind9
    apt update
    apt install bind9

#verifie si bind9 est installé
    if ! which bind9 > /dev/null; then
    echo -e "bind9 packages not installed, please advise your system administrator".
    fi


fileNamedConf="/users/info/etu-2a/boussitt/SAE4/test.txt"
fileNamedConfLocal="/users/info/etu-2a/boussitt/SAE4/a.conf.local"

#NAME.CONF


#ajouter le nom du serveur DNS dans /hostsname
# cat > /etc/network/interfaces << 'EOL'
   # This fileNamedConf contain the FQDN of the DNS server
 #  dns.cipher.intra

#EOL

: <<COMMENT
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


COMMENT
#creer la zone de l'intranet

    sed -i '$a\zone "dmz.cipher." {\ntype master;\nfile "/etc/bind/db.dmz.cipher";\n};' "$fileNamedConf"

#vérifier si la ligne "include named.conf.local" est présente
    if grep "include "$fileNamedConfLocal";" $fileNamedConf; then
        echo "is(are) present"
    else
        echo "include named.conf.local is added to the fileNamedConf"
        #ajouter à la fin du fichier le include "etc/bind/named.conf.local"
        sed -i "$a\include "$fileNamedConfLocal";" $fileNamedConf
        echo "added"
    fi

#NAMED.CONF.LOCAL

#overwriting de named.conf.local
    #rm $fileNamedConfLocal
    #cp dmzNamed.conf.local $fileNamedConfLocal

#creer un fichier de zone pour la dmz
    touch /etc/bind/db.dmz.cipher.

#ajouter les enregistrements dans le fichier de zone
    cat > /etc/bind/db.dmz.cipher. << 'EOL'
    $TTL 86400
    @       IN      SOA     dmz.cipher.com. root.dmz.cipher. (
                            2020102001      ; Serial
                            3600            ; Refresh
                            1800            ; Retry
                            604800          ; Expire
                            86400 )         ; Minimum TTL
    ;
    @       IN      NS      dmz.cipher.
    dns       IN      A       192.168.0.4
    web       IN      A       192.168.0.3
EOL

#ajouter les directives au fichier interfaces
    cat > /etc/network/interfaces << 'EOL'
    iface eth1 inet static
    address 192.168.0.4
    netmask 255.255.255.0
    dns-nameservers 192.168.0.4
EOL

#redemarrer les services 
    systemctl restart bind9
    systemctl restart networking
    ifdown eth1 && ifup eth1