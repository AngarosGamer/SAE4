#!/usr/sbin/nft -f

# Script à executer sur le routeur principal de l'infrastrucutre, se charge de créer les règles agissant sur les connexions à destination du routeur lui-même.

# Il est recommandé d'utiliser le script main_firewall.sh (qui appelle ce script) pour configurer le firewall

# Règle SSH sur le routeur

# Ping sur le routeur
add rule filter input icmp type echo-request limit rate 50/second ip saddr 192.168.0.0/22 accept # Autoriser jusqu'à 50 requêtes ICMP par seconde du réseau interne de l'infrastructure
add rule filter input icmp type echo-request limit rate over 50/second ip saddr 192.168.0.0/22 drop # Ne pas autoriser plus de 50 requêtes ICMP par seconde du réseau interne de l'infrastructure
add rule filter input icmp type echo-request drop # Ne pas autoriser les requêtes ICMP de l'extérieur

# Politique par défaut : DROP (whitelist)
add rule filter input drop