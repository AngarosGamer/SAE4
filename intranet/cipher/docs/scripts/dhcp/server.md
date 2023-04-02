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

Le script va d'abord modifier le fichier /etc/default/isc-dhcp-server pour ajouter l'interface enp1s0,
Puis le script va télécharger un fichier [dhcpd.conf](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dhcp/dhcpd.conf),
Il va ensuite modifier le fichier dhclient.conf pour qu'il prenne en compte le serveur dns
Et enfin il redemarre le service isc-dhcp-server.service
