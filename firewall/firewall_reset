#!/usr/sbin/nft -f


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
    chain postrouting {
        type filter nat postrouting priority 0; policy accept;
        masquerade
    }
}
