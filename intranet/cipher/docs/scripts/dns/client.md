---
hide:
  - navigation
---
# DNS Client

Le script d'installation du client DNS permet de configurer une machine pour qu'elle utilise le serveur DNS (voir [DNS Server](server_intranet.md)). Il est à installer sur chaque machine cliente du réseau.

## Téléchargement

Retrouvez le script téléchargeable ici : [DNS Client](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dns/dns_intranet/dns_intranet_install_client.sh)

## Prérequis

- Avoir une machine virtuelle Debian 11 installée (voir [Installation-machine](../installation-machine.md))
- Avoir une connexion internet
- Avoir un accès `root` au serveur

## Installation

Le script va tout d'abord editer le fichier /etc/network/interfaces afin de s'assurer de la gestion de l'interface "enp1s0" par le client.
Le script va ensuite redemarrer le service networking
Après quoi il va associer l'IP 192.168.1.6 au serveur DNS (voir [DNS Server](server_intranet.md))