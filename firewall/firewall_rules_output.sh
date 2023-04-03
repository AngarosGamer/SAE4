#!/usr/sbin/nft -f

# Script à executer sur le routeur principal de l'infrastrucutre, se charge de créer les règles agissant sur les connexions sortantes du routeur lui-même.

# Il est recommandé d'utiliser le script main_firewall.sh (qui appelle ce script) pour configurer le firewall

# Règle SSH sur le routeur


# Ping depuis le routeur sur d'autres machines
nft add rule filter output icmp type echo-request limit rate 50/second ip daddr 192.168.0.0/22 accept # Autoriser jusqu'à 50 requêtes ICMP par seconde vers le réseau interne de l'infrastructure
nft add rule filter output icmp type echo-request limit rate over 50/second ip daddr 192.168.0.0/22 drop # Ne pas autoriser plus de 50 requêtes ICMP par seconde vers le réseau interne de l'infrastructure

# Politique par défaut : ACCEPT (blacklist)
nft add rule filter output accept # On accepte toutes les connexions sortantes par défaut
