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

dhcp_server="192.168.1.8" # Addresse serveur

echo "Test du serveur DHCP sur $dhcp_server..."

# nslookup pour vérifier que le serveur DHCP existe
if ! nslookup -type=srv _dhcp._udp.$dhcp_server >/dev/null 2>&1; then
  echo "Serveur DHCP non trouvé!"
  exit 1
else
  echo "Serveur DHCP trouvé, envoi d'un DHCP Request de test"
fi

# Envoi de 3 DHCP Request pour tester
for i in {1..3}; do
  echo ""
  echo "Envoi tu test DHCP n°$i..."
  result=$(echo -e '\x01\x01\x06\x00\x15\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20' | socat - UDP4-DATAGRAM:$dhcp_server:67,so-broadcast)
  if [[ "$result" == *"DHCPOFFER"* ]]; then
    echo "Réponse correcte du serveur DHCP"
    exit 0
  fi
done

echo "Le serveur DHCP n'a pas répondu"


echo "Test d'accès à un compte du LDAP sur la machine poste-4"

ssh -q -o BatchMode=yes $userldap1@$192.168.2.4 "echo Connection successful" >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "L'accès SSH à $userldap1@$192.168.2.4 est disponible"
else
  echo "L'accès SSH à $userldap1@$192.168.2.4 n'est pas disponible"
fi