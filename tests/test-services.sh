#!/bin/bash

# Test de connectivite
# Vérifie que les services sont en marche en faisant des appels dépendant du service

echo "Test du serveur DNS :"

host="google.com transit.iut2.univ-grenoble-alpes.fr"

for address in $host; do
    if [ "$(dig +short -t srv "$address")" ]; then
        echo "Réponse de $address - service DNS semble en marche"
    else
        echo "Pas de réponse de $address - service DNS semble en panne"
    fi
done

echo "Test du serveur DHCP :"

mac="$(cat /sys/class/net/enp8s0/address)"
ip=$(hostname -I)

if [ "$(dhcping -c "$ip" -s 192.168.1.8 -h "$mac")" ]; then
    echo "Réponse de $ip - service DHCP semble en marche"
else
    echo "Pas de réponse de $ip - service DHCP semble en panne"
fi