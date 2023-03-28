#!/bin/bash
#Verfie si le script est lancé en tant que root
    if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être lancé en tant que root" 
    exit 1
    fi

#installe les packages bind9
    apt -y update
    apt -y install bind9

#verifie si bind9 est installé
    if ! which bind9 > /dev/null; then
    echo -e "bind9 packages not installed, please advise your system administrator".
    fi
#completer le fichier named.conf.local
    cat > /etc/bind/named.conf.local << 'EOL'
    zone "users.cipher" {
        type master;
        file "/etc/bind/db.users.cipher.";
    };
    zone "servers.cipher" {
        type master;
        file "/etc/bind/db.servers.cipher.";
    };
EOL

#fileNamedConf="/users/info/etu-2a/boussitt/SAE4/test.txt"
#fileNamedConfLocal="/users/info/etu-2a/boussitt/SAE4/a.conf.local"

# fichier de zone pour les serveurs 
    touch /etc/bind/db.servers.cipher.
#creer un fichier de zone pour les machines de l'intranet
    touch /etc/bind/db.users.cipher.

#remplir le fichier db.servers.cipher.
    cat > /etc/bind/db.servers.cipher. << 'EOL'
    $TTL 86400
    @       IN      SOA     servers.cipher.com. root.servers.cipher. (
                            2020102001      ; Serial
                            3600            ; Refresh
                            1800            ; Retry
                            604800          ; Expire
                            86400 )         ; Minimum TTL
    ;
    @       IN      NS      servers.cipher.
    sgbd      IN      A     192.168.1.3
    log       IN      A     192.168.1.4
    files     IN      A     192.168.1.5
    dns       IN      A     192.168.1.6
    ldap      IN      A     192.168.1.7
    dhcp      IN      A     192.168.1.8
    kerberos  IN      A     192.168.1.9

EOL
#remplir le fichier db.users.cipher.
    cat > /etc/bind/db.users.cipher. << 'EOL'
    $TTL 86400
    @       IN      SOA     users.cipher.com. root.users.cipher. (
                            2020102001      ; Serial
                            3600            ; Refresh
                            1800            ; Retry
                            604800          ; Expire
                            86400 )         ; Minimum TTL
    ;
    @       IN      NS      users.cipher.
EOL

#ajouter les directives au fichier interfaces
    cat > /etc/network/interfaces << 'EOL'
    iface eth1 inet static
    address 192.168.1.6
    netmask 255.255.255.0
    dns-nameservers 192.168.1.6
EOL

#redemarrer les services 
    systemctl restart bind9
    systemctl restart networking
    ifdown eth1 && ifup eth1