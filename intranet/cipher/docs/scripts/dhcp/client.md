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

le script va d'abord réécrire dans son intégralité le fihier /etc/network/interfaces pour qu'il remplace l'IP statique par une IP qu'il demandera au [DHCP Server](server.md)
Et redemarre simplement le service networking 