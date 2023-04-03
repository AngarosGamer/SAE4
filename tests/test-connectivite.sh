#!/bin/bash

# Test de connectivite
# Vérifie que les machines sont joignables par ping ICMP

declare -A machines=(["192.168.0.2"]="dmz-routeur" 
                    ["192.168.0.3"]="dmz-webserver"
                    ["192.168.0.4"]="dmz-dns"
                    ["192.168.1.2"]="serveur-routeur"
                    ["192.168.1.3"]="serveur-postgres"
                    ["192.168.1.4"]="serveur-log"
                    ["192.168.1.5"]="serveur-fichiers"
                    ["192.168.1.6"]="serveur-dns"
                    ["192.168.1.7"]="serveur-ldap"
                    ["192.168.1.8"]="serveur-dhcp"
                    ["192.168.1.9"]="serveur-kerberos"
                    ["192.168.1.10"]="serveur-zabbix"
                    ["192.168.2.2"]="machines-routeur"
                    ["192.168.2.3"]="machines-poste-3"
                    ["192.168.2.4"]="machines-poste-4"
                    ["192.168.2.5"]="machines-poste-5"
)

for ip in "${!machines[@]}"; do
    if ping -c 1 "$ip" > /dev/null; then
        printf "%-16s : %-20.20s est joignable" "$ip" "${machines[$ip]}"
    else
        printf "%-16s : %-20.20s n'est pas joignable" "$ip" "${machines[$ip]}"
    fi
done