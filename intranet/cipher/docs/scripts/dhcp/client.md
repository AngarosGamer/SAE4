---
hide:
  - navigation
---
# DHCP Client

Le script d'installation du client DHCP permet de configurer une machine pour qu'elle reçoive une adresse IP dynamiquement de la part du serveur DHCP mis en place (voir [DHCP Server](server.md)). Il est à installer sur chaque machine cliente du réseau.

## Téléchargement

Retrouvez le script téléchargeable ici : [DHCP Client](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dhcp/dhcp_install_client.sh)

## Prérequis

- Avoir une machine virtuelle Debian 11 installée (voir [Installation-machine](../installation-machine.md))
- Avoir une connexion internet
- Avoir un accès `root` sur la machine cliente

## Installation

Pour installer le LDAP coté client, il suffit de lancer le script `dhcp_install_client.sh` téléchargé au-dessus en tant que `root` :

```bash
utilisateur@machine:~# ./dhcp_install_client.sh
```