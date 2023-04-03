#!/usr/sbin/nft -f

# Script à executer sur le routeur principal de l'infrastrucutre, se charge de créer les règles dictant les choix sur les connexions transitant par ce routeur.
# Se référer au script firewall_rules_input pour les règles d'entrée directement sur le routeur lui-même.

# Il est recommandé d'utiliser le script main_firewall.sh (qui appelle ce script) pour configurer le firewall


# Règles serveur Kerberos
nft add rule filter forward udp dport 88 ip daddr 192.168.1.9 ip saddr 192.168.0.0/22 ct state new accept
nft add rule filter forward tcp dport 88 ip daddr 192.168.1.9 ip saddr 192.168.0.0/22 ct state new accept
nft add rule filter forward udp dport 88 ip daddr 192.168.0.0/22 ip saddr 192.168.1.10 ct state new accept

# Règles serveur DHCP
nft add rule filter forward udp dport 67 ip daddr 192.168.1.8 ip saddr 192.168.0.0/22 ct state new accept
nft add rule filter forward tcp dport 68 ip daddr 192.168.1.8 ip saddr 192.168.0.0/22 ct state new accept

# Règles serveur LDAP
nft add rule filter forward tcp dport 636 ip daddr 192.168.1.7 ip saddr 192.168.0.0/22 ct state new accept

# Règles serveurs DNS
nft add rule filter forward udp sport 53 ip daddr 192.168.1.6 ip saddr 192.168.0.0/22 ct state new accept
nft add rule filter forward udp sport 53 ip daddr 192.168.0.4 ip saddr 192.168.0.0/22 ct state new accept

# Règles serveur de fichiers
nft add rule filter forward tcp dport 2049 ip daddr 192.168.1.5 ip saddr 192.168.2.0/22 ct state new accept

# Règles serveur de log
nft add rule filter forward tcp dport 19532 ip daddr 192.168.1.4 ip saddr 192.168.0.0/22 ct state new accept
nft add rule filter forward tcp dport http ip daddr 192.168.1.4 ip saddr 192.168.0.0/22 ct state new accept

# Règles serveur postgres
nft add rule filter forward tcp dport 5432 ip daddr 192.168.1.3 ip saddr 192.168.128.0/22 ct state new accept

# Règles serveur web (HTTP et HTTPS)
nft add rule filter forward tcp dport http ip daddr 192.168.0.3 ip saddr 192.168.0.0/22 limit rate 50 kbytes/second ct state new tcp flags == syn drop
nft add rule filter forward tcp dport http ip daddr 192.168.0.3 ip saddr 192.168.0.0/22 limit rate over 50 kbytes/second ct state new tcp flags == syn accept
nft add rule filter forward tcp dport https ip daddr 192.168.0.3 ip saddr 192.168.0.0/22 ct state new tcp flags == syn accept

# Règles pour ICMP
nft add rule filter forward icmp type echo-request limit rate 50/second ip saddr 192.168.0.0/22 accept # Autoriser jusqu'à 50 requêtes ICMP par seconde du réseau interne de l'infrastructure
nft add rule filter forward icmp type echo-request limit rate over 50/second ip saddr 192.168.0.0/22 drop # Ne pas autoriser plus de 50 requêtes ICMP par seconde du réseau interne de l'infrastructure
nft add rule filter forward icmp type echo-request drop # Ne pas autoriser les requêtes ICMP de l'extérieur

# Règles de SSH
nft add rule filter forward tcp dport ssh ip saddr 192.168.0.0/22 ct state new tcp flags == syn accept

nft add rule filter forward ct state established accept # Accepter les connexions établies par défaut

nft add rule filter forward drop # refuser toutes les connexions ne répondant pas aux critères précédents
