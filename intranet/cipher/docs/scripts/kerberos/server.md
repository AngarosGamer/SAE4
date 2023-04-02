---
hide:
  - navigation
---
# Installer Kerberos sur un serveur

Kerberos est un système d'authentification qui permet de s'authentifier sur un serveur, et de pouvoir ensuite utiliser les services de ce serveur.
Nous allons ici voir comment installer Kerberos sur un serveur, afin de pouvoir ensuite l'utiliser pour s'authentifier sur un client.

## Prérequis

- Une connexion internet active est nécessaire pour lancer ce script.
- Un accès `root` à la machine virtuelle

## Téléchargement

Le script d'installation de Kerberos est disponible ici : [Installation Kerberos](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/kerberos/kerberos-server.sh)

## Utilisation

Pour installer Kerberos sur un serveur, il suffit de lancer le script `kerberos-server.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./kerberos-server.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x kerberos-server.sh
```

Ce script va utiliser des fichiers de configuration pour Kerberos que nous avons écrit ici :

- [`KRB5 Kerberos`](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/kerberos/krb5.conf)
- [`KDC Kerberos`](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/kerberos/kdc.conf)

Le script d'installation n'est pas entièrement fonctionnel. Cette page est simplément pour référence vers le début du travail mais ne fournira pas une installation complète et fonctionnelle de Kerberos.
