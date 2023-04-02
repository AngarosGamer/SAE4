---
hide:
  - navigation
---
# Ajout de règles particulières

Les autres scripts se chargent de la création et application en masse de règles pour le pare-feu. Ce script permet de rajouter des règles simples directement dans le pare-feu, une par une. Ces règles ne seront pas ajoutées au scripts, donc elles ne seront pas réappliquées en cas de réinitialisation du pare-feu.

C'est un script facile d'utilisation mais qui nécessite toutefois une certaine connaissance des règles de pare-feu et de l'infrasttucture globale. Il est donc conseillé de ne pas l'utiliser si vous n'êtes pas sûr de ce que vous faites.

## Prérequis

- Un accès `root` à la machine virtuelle

## Téléchargement

Le script d'ajout de règle du pare-feu est disponible ici : [Ajout de règles pare-feu](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/firewall/add_firewall_rule.sh)

## Utilisation

Pour ajouter des règles dans le pare-feu, il suffit de lancer le script `add_firewall_rule.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./add_firewall_rule.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x add_firewall_rule.sh
```

Ce script ajoute une seule règle à la fois. Il est donc conseillé de l'utiliser en boucle pour ajouter plusieurs règles. De plus, les règles ne sont pas sauvegardées, donc elles ne seront pas réappliquées en cas de réinitialisation du pare-feu.

Ce script n'a pas vocation a être modifié. Il est possible de modifier ce script pour ajouter des fonctionnalités, mais c'est un travail avancé.
