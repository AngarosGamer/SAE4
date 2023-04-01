#!/usr/sbin/nft -f

# Script de réinitialisation du firewall
# Permet de rapidement revenir à une configuration de base, sans aucune règles de protection
# /!\ ATTENTION /!\ Ce script supprime toutes les règles du firewall, sans l'utilisation des autres scripts de configuration du firewall l'infrastructure est vulnérable
# Pour éviter de poser des problèmes, il est recommandé d'utiliser le script main_firewall.sh (après édition des règles) pour reconfigurer le firewall

# Supprimer toutes les règles du pare-feu
flush ruleset

# Accepter toutes les connexions entrantes et sortantes
table ip filter {
    chain input {
        type filter hook input priority 0; policy accept;
    }
    chain output{
        type filter hook output priority 0; policy accept;
    }
    chain forward {
        type filter hook forward priority 0; policy accept;
    }
    chain postrouting {
        type filter nat postrouting priority 0; policy accept;
        masquerade
    }
}
