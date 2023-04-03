---
hide:
  - navigation
---
# Règles d'entrée

Les règles d'entrée sont les règles qui définissent quelles connexions sont autorisées à entrer sur la machine, qui lui sont directement destinées. Ce script se charge de paramétrer les connexions entrantes automatiquement pour les règles permanentes.

ATTENTION: Ce script n'est utilisé que pour les règles d'entrée. Ce n'est pas une installation complète du pare-feu.
Il est conseillé d'utiliser ce script uniquement en combinaison avec les autres scripts d'installation du pare-feu.

## Prérequis

- Un accès `root` à la machine virtuelle

## Téléchargement

Le script de règles d'entrée du pare-feu est disponible ici : [Règles d'entrée pare-feu](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/firewall/firewall_rules_input.sh)

## Utilisation

Pour les règles d'entrée dans le pare-feu, il suffit de lancer le script `firewall_rules_input.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./firewall_rules_input.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x firewall_rules_input.sh
```

Si ce script est utilisé seul, alors la machine aura un pare-feu contenant des règles particulières aux paquets entrants. Il est donc conseillé d'utiliser ce script uniquement en combinaison avec les autres scripts d'installation du pare-feu.

Ce script a vocation a être modifié pour ajouter ou modifier les règles d'entrée. Il est donc possible de modifier ce script pour ajouter des règles d'entrée.
