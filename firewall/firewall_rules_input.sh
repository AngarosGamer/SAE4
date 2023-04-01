#!/usr/sbin/nft -f

# Règle SSH sur le routeur


# Ping sur le routeur
add rule filter input icmp type echo-request limit rate 50/second ip saddr 192.168.0.0/22 accept # Autoriser jusqu'à 50 requêtes ICMP par seconde du réseau interne de l'infrastructure
add rule filter input icmp type echo-request limit rate over 50/second ip saddr 192.168.0.0/22 drop # Ne pas autoriser plus de 50 requêtes ICMP par seconde du réseau interne de l'infrastructure
add rule filter input icmp type echo-request drop # Ne pas autoriser les requêtes ICMP de l'extérieur

# Politique par défaut : DROP (whitelist)
add rule filter input drop