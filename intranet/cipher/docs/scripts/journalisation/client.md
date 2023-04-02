---
hide:
  - navigation
---
# Installer la journalisation centralisée sur une machine cliente

La journalisation centralisée permet de centraliser les logs de plusieurs machines sur un serveur. Cela permet de pouvoir facilement consulter les logs de plusieurs machines depuis un seul endroit.
Nous nous intéresserons ici à l'installation de la journalisation centralisée sur une machine cliente.

## Prérequis

- Une connexion internet active est nécessaire pour lancer ce script.
- Un accès `root` à la machine virtuelle

## Téléchargement

Le script d'installation de la journalisation centralisée est disponible ici : [Installation journalisation cliente](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/journalisation/journald_install_client.sh)

## Utilisation

Pour installer la journalisation centralisée sur un client, il suffit de lancer le script `journald_install_client.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./journald_install_client.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x journald_install_client.sh
```

Attention, ce script emploie des paramètres do configuration directement dans le script. Il est donc nécessaire de modifier le script si l'on souhaite changer les paramètres de configuration.

L'installation se fait cependant automatiquement sans configuration supplémentaire nécessaire.
