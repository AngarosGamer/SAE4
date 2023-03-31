#!/bin/bash
# Fonctions
    function error {
        >&2 echo -e "\033[1;31mERROR:\033[0m $1"; shift
        exit "${1:-1}"
    }
#Verfie si le script est lancé en tant que root
    if [[ $EUID -ne 0 ]]; then
        echo "Ce script doit être lancé en tant que root" 
        exit 1
    fi

#installe les packages bind9
    apt -y install bind9 || error "L'installation a échoué."

fileNamedConf="/users/info/etu-2a/boussitt/SAE4/test.txt"
fileNamedConfLocal="/users/info/etu-2a/boussitt/SAE4/a.conf.local"

#NAME.CONF

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
iface enp1s0 inet static
address 192.168.0.4
netmask 255.255.255.0
dns-nameservers 192.168.0.4
EOL

#redemarrer les services 
    systemctl restart bind9
    systemctl restart networking
