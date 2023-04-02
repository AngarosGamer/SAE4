---
hide:
  - navigation
---
# Post-Installation de la machine virtuelle

Juste après la création d'une machine virtuelle, il est souvent nécessaire d'effectuer des actions supplémentaires de configuration. Ce script automatise ces actions et permet de les effectuer en une seule commande.

Ce script est principalement dédié aux machines clientes, car les paquets qui seront installés sont ceux qui sont nécessaires pour les clients.

## Prérequis

- Machine virtuelle installée
- Connexion internet active
- Avoir un accès `root` à la machine virtuelle

## Téléchargement

Le script de post-installation de la machine virtuelle est disponible ici : [Post-Installation Machine Virtuelle](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/installation-machine/post-install.sh)

## Installation

Pour utiliser ce script sur une nouvelle machine virtuelle, le lancer en tant que `root` :

```bash
utilisateur@machine:~# ./post-install.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
utilisateur@machine:~# chmod +x post-install.sh
```

## Configuration

Le script de post-installation effectue les actions suivantes :

- Modification du nom de la machine virtuelle

Il faudra ici rentrer un nom pour la machine virtuelle. Ce nom sera utilisé pour identifier la machine virtuelle dans le réseau.

- Ajout d'un utilisateur

Cet utilisateur sera utilisé pour se connecter à la machine virtuelle, et pour accomplir les tâches générales liées à cette machine. Il faudra donc rentrer un nom d'utilisateur et un mot de passe pour cet utilisateur.

- Suppression de l'utilisateur d'installation

Par défaut, lors de l'installation, un utilisateur par défaut est mis en place. Il n'a plus d'utilité dès la machine installée, donc le script le supprime.

- Modification du mot de passe de l'utilisateur `root`

Le mot de passe par défaut du compte `root` est `root`, ce qui est peu sécurisé. Le script demande à l'utilisateur de le changement pour améliorer la sécurité de la machine virtuelle.

- Installation de l'agent Zabbix

L'infrastructure utilise Zabbix afin de surveiller les machines virtuelles connectées au réseau. L'agent Zabbix est installé sur chaque machine virtuelle afin de permettre à Zabbix de surveiller la machine virtuelle.

- Installation du LDAP client

Le LDAP permet d'authentifier et identifier les utilisateurs sur le réseau de l'infrastructure. L'installation du client LDAP permet aux machines virtuelles de se connecter à ce serice centralisé pour gérer les utilisateurs et l'authentification.

Voir le script [LDAP Client](../ldap/client.md) pour plus d'informations.

- Installation du NFS (serveur de fichiers) client

Pour faciliter l'utilisation de l'infrastructure, un serveur de fichiers est mis en place. Ce serveur permet de partager des fichiers entre les machines virtuelles à partir d'un serveur central. L'installation du client NFS permet aux machines virtuelles de se connecter à ce serveur de fichiers.

Voir le script [NFS Client](../nfs/client.md) pour plus d'informations.