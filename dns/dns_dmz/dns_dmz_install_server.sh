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

#verifie si bind9 est installé
    if ! which bind9 > /dev/null; then
    echo -e "bind9 packages not installed, please advise your system administrator".
    fi
 
#réécrire le fichier /etc/bind/named.conf de sorte qu'il ait les bons includes
    cat > /etc/bind/named.conf << 'EOL'
include "/etc/bind/named.conf.options"
include "/etc/bind/named.conf.local"
include "/etc/bind/named.conf.defaulte-zones"
EOL

#completer le fichier named.conf.local
    cat > /etc/bind/named.conf.local << 'EOL'
zone "dmz.cipher" {
    type master;
    file "/etc/bind/db.dmz.cipher";
};
EOL
echo "named.conf.local complété"


#creer un fichier de zone pour la dmz
    touch /etc/bind/db.dmz.cipher.

#ajouter les enregistrements dans le fichier de zone
    cat > /etc/bind/db.dmz.cipher. << 'EOL'
$TTL 604800
@       IN      SOA     dmz.cipher.com. root.dmz.cipher. (
                        1               ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Minimum TTL
;
@       IN      NS      dmz.cipher.
@       IN      A       192.168.0.4
dns       IN      A       192.168.0.4
web       IN      A       192.168.0.3
EOL
echo "Fichier db.dmz.cipher. créé"
#ajouter les directives au fichier interfaces
    cat > /etc/network/interfaces << 'EOL'
iface enp1s0 inet static
address 192.168.0.4
netmask 255.255.255.0
dns-nameservers 192.168.0.4
EOL
echo "Fichier interfaces modifié"

#modifier le fichier named pour etre en ipv4
    sed -i 's/OPTIONS="-u bind"/OPTIONS="-u bind -4"/g' /etc/default/named
    
#redemarrer les services 
    systemctl restart bind9
    systemctl restart networking
