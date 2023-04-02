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
zone "users.cipher" {
    type master;
    file "/etc/bind/db.users.cipher";
};
zone "cipher.com" {
    type master;
    file "/etc/bind/db.cipher.com";
};
EOL
echo "named.conf.local complété"
#fileNamedConf="/users/info/etu-2a/boussitt/SAE4/test.txt"
#fileNamedConfLocal="/users/info/etu-2a/boussitt/SAE4/a.conf.local"

# fichier de zone pour les serveurs 
    touch /etc/bind/db.cipher.com
#creer un fichier de zone pour les machines de l'intranet
    touch /etc/bind/db.users.cipher

#remplir le fichier db.servers.cipher.
    cat > /etc/bind/db.cipher.com << 'EOL'
$TTL 604800
@       IN      SOA     cipher.com. root.cipher.com. (
                        3               ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Minimum TTL
;
@       IN      NS      cipher.com.
@       IN      A       192.168.1.6
postgres      IN      A     192.168.1.3
log           IN      A     192.168.1.4
files         IN      A     192.168.1.5
dns           IN      A     192.168.1.6
ldap          IN      A     192.168.1.7
kerberos      IN      A     192.168.1.9
zabbix        IN      A     192.168.1.10
EOL
echo "Fichier db.cipher.com créé"
#remplir le fichier db.users.cipher.
    cat > /etc/bind/db.users.cipher << 'EOL'
$TTL 604800
@       IN      SOA     users.cipher.com. root.users.cipher. (
                        2               ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Minimum TTL
;
@       IN      NS      users.cipher.
@       IN      A       192.168.1.6
EOL
echo "Fichier db.users.cipher. créé"
#ajouter les directives au fichier interfaces
    cat > /etc/network/interfaces << 'EOL'
iface enp1s0 inet static
address 192.168.1.6
netmask 255.255.255.0
dns-nameservers 192.168.1.6
EOL
echo "Fichier interfaces modifié"

#modifier le fichier named pour etre en ipv4
    sed -i 's/OPTIONS="-u bind"/OPTIONS="-u bind -4"/g' /etc/default/named

#redemarrer les services 
    systemctl restart bind9
    systemctl restart networking
