---
hide:
  - navigation
---
# Problèmes rencontrés ?

## Installation de VM

### Pas de connexion internet

Assurez vous que l'interface réseau correspond bien à ce que vous souhaitez, et que la configuration IP est correcte.

Par exemple, si votre interface est sur le réseau `192.168.0.0/24`, assurez vous que l'adresse IP de la machine virtuelle est bien dans ce réseau:
`192.168.0.1 - 192.168.0.254`

Si cela semble bon, l'erreur peut venir de la route par défaut. Pour vérifier cela, lancez la commande suivante:

```bash
root@machine:~# ip route
```

Et que l'adresse montrée est celle de votre routeur sur le réseau.

Dernièrement, cela pourrait être un problème lié au NAT. Assurez vous que le NAT est bien activé sur votre routeur et que celui-ci est bien configuré pour rediriger les paquets vers le réseau. Si vous avez un pare-feu, vous pouvez aussi essayer de modifier les règles qui pourraient bloquer ce type de connexions.

## Installation de pare-feu

### Les règles ne sont pas appliquées

Assurez vous que le pare-feu est bien lancé et actif. Pour cela, vous pouvez utiliser la commande suivante:

```bash
root@machine:~# systemctl status nftables
```

Si le pare-feu est bien lancé, vous pouvez vérifier les règles qui sont appliquées avec la commande suivante:

```bash
root@machine:~# nft list ruleset
```

Assurez-vous par ailleurs que les règles ont la bonne chaîne de traitement et le bon hook. Par exemple, si vous souhaitez que les règles soient appliquées aux paquets transitants par l'interface `eth0`, vous devez utiliser le hook `input` et la chaîne `prerouting`:
