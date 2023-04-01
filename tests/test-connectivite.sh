#!/bin/bash

# Test de connectivite
# Vérifie que les machines sont joignables par ping ICMP

machines="192.168.0.2 192.168.0.3 192.168.0.4 192.168.1.2 192.168.1.3 192.168.1.4 192.168.1.5 192.168.1.6 192.168.1.7 192.168.1.8 192.168.1.9 192.168.1.10 192.168.2.2 192.168.2.3 192.168.2.4 192.168.2.5"

for ip in $machines; do
    if ping -c 1 "$ip" > /dev/null; then
        echo "$ip est joignable"
    else
        echo "$ip n'est pas joignable"
    fi
done