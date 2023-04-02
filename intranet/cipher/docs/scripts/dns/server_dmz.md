---
hide:
  - navigation
---
# DNS DMZ Serveur

Le serveur DNS de la DMZ permet de distribuer les noms de domaine des machines de l'intranet aux machines extérieures au réseau.

## Téléchargement

Retrouvez le script téléchargeable ici : [DNS DMZ Server](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dns/dns_dmz/dns_dmz_install_server.sh)

## Prérequis

- Avoir une machine virtuelle Debian 11 installée (voir [Installation-machine](../installation-machine.md))
- Avoir une connexion internet
- Avoir un accès `root` au serveur

## Installation

Pour installer le LDAP coté client, il suffit de lancer le script `dns_dmz_install_server.sh` téléchargé au-dessus en tant que `root` :

```bash
utilisateur@machine:~# ./dns_dmz_install_server.sh
```