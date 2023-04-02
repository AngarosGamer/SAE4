---
hide:
  - navigation
---
# DHCP Serveur

Le serveur DHCP permet de distribuer des adresses IP aux machines du réseau. Il peut le faire de manière statique ou dynamique, en attribuant une plage d'adresses IP à un réseau.

## Téléchargement

Retrouvez le script téléchargeable ici : [DHCP Server](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dhcp/dhcp_install_server.sh)

## Prérequis

- Avoir une machine virtuelle Debian 11 installée (voir [Installation-machine](../installation-machine.md))
- Avoir une connexion internet
- Avoir un accès `root` au serveur

## Installation

Pour installer le serveur DHCP, il suffit de lancer le script `dhcp_install_server.sh` téléchargé au-dessus en tant que `root` :

```bash
utilisateur@machine:~# ./dhcp_install_server.sh
```

Votre serveur est maintenant configurée