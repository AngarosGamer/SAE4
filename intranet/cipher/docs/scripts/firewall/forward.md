---
hide:
  - navigation
---
# Règles de redirection

Lorsque le pare-feu est installé sur un routeur, les paquets ne sont pas forcément à destination de la machine elle-même. Il faut alors appliquer des règles de redirection pour filtrer les paquets.

ATTENTION: Ce script n'est utilisé que pour les règles de redirection. Ce n'est pas une installation complète du pare-feu.
Il est conseillé d'utiliser ce script uniquement en combinaison avec les autres scripts d'installation du pare-feu.

## Prérequis

- Un accès `root` à la machine virtuelle

## Téléchargement

Le script de règles de redirection du pare-feu est disponible ici : [Redirection pare-feu](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/firewall/firewall_rules_forward.sh)

## Utilisation

Pour les règles de redirection dans le pare-feu, il suffit de lancer le script `firewall_rules_forward.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./firewall_rules_forward.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x firewall_rules_forward.sh
```

Si ce script est utilisé seul, alors la machine aura un pare-feu contenant des règles particulières à la redirection de paquets. Il est donc conseillé d'utiliser ce script uniquement en combinaison avec les autres scripts d'installation du pare-feu.

Ce script a vocation a être modifié pour ajouter ou modifier les règles de redirection. Il est donc possible de modifier ce script pour ajouter des règles de redirection.
