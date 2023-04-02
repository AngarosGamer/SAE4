---
hide:
  - navigation
---
# Mise en place de Postgres

Postgres est un serveur de base de données, qui permet de stocker des données de manière sécurisée, et de les récupérer facilement à l'aide du langage SQL, par exemple en passant par le réseau.

## Prérequis

- Une connexion internet active est nécessaire pour lancer ce script.
- Un accès `root` à la machine virtuelle
- Un espace de stockage d'environ 5Go disponibles

## Téléchargement

Le script de mise en place de Postgres est disponible ici : [Installation Postgres](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/sgbd/postgres_install.sh)

## Utilisation

Pour installer le serveur postgres, il suffit de lancer le script `postgres_install.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./postgres_install.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x postgres_install.sh
```

Le script va installer les packages nécessaires à l'installation de Postgres, et va ensuite lancer l'installation de Postgres avec la configuration par défaut.
Ce script est entièrement automatique, et ne nécessite pas d'autres changements.
