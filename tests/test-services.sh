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

printf "\nTest du serveur DHCP :"

mac="$(cat /sys/class/net/enp8s0/address)"
ip=$(hostname -I)

if [ "$(dhcping -c 192.168.1.2 -s 192.168.1.8 -h "$mac")" ]; then
    echo "Réponse de 192.168.1.8 - service DHCP semble en marche"
else
    echo "Pas de réponse de 192.168.1.8 - service DHCP semble en panne"
fi

echo "Test d'accès à un compte du LDAP sur la machine poste-4"

ssh -q -o BatchMode=yes $userldap1@$192.168.2.4 "echo Connection successful" >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "L'accès SSH à $userldap1@$192.168.2.4 est disponible"
else
  echo "L'accès SSH à $userldap1@$192.168.2.4 n'est pas disponible"
fi