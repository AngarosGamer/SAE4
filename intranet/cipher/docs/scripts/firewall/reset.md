---
hide:
  - navigation
---
# Réinitialiser le pare-feu

Le pare-feu doit parfois être réinitialisé. Cela peut être nécessaire si le pare-feu est corrompu ou si des règles ont été ajoutées manuellement. C'est aussi pratique quand on modifie des règles de pare-feu et que l'on doit en supprimer certaines.

ATTENTION : Cette opération supprime toutes les règles de pare-feu. Il est donc nécessaire de les réinstaller après avoir réinitialisé le pare-feu, sinon le pare-feu ne sera plus fonctionnel.
Il est conseillé d'utiliser ce script uniquement en combinaison avec les scripts d'installation du pare-feu.

## Prérequis

- Un accès `root` à la machine virtuelle

## Téléchargement

Le script de réinitialisation du pare-feu est disponible ici : [Réinitialisation pare-feu](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/firewall/firewall_reset.sh)

## Utilisation

Pour réinitialiser les règles de pare-feu, il suffit de lancer le script `firewall_reset.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./firewall_reset.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x firewall_reset.sh
```

Toutes les règles seront alors supprimées, et la configuration sera remise à une configuration basique avec le NAT. Le pare-feu n'offrira alors plus aucune protection.

Ce script n'a pas vocation à être modifié. Il est donc recommandé de ne pas le modifier, ou alors de le modifier avec précaution.
