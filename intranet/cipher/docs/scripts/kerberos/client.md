---
hide:
  - navigation
---
# Installer Kerberos sur machine cliente

L'installation de Kerberos sur une machine cliente permet de pouvoir se connecter à un serveur Kerberos afin d'en utiliser les services.
C'est une installation simple qui se fait ici sous la forme d'un script bash.

## Prérequis

- Connexion internet active
- Avoir un accès `root` à la machine virtuelle

## Téléchargement

Le script d'installation de Kerberos est disponible ici : [Installation Kerberos](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/kerberos/kerberos-client.sh)

## Utilisation

Pour installer Kerberos sur une machine cliente, il suffit de lancer le script `kerberos-client.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./kerberos-client.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x kerberos-client.sh
```

Le script va installer les packages nécessaires à l'installation de Kerberos, et va ensuite lancer l'installation de Kerberos avec la configuration par défaut de Kerberos coté client.
