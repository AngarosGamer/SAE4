---
hide:
  - navigation
---
# DNS Intranet Serveur

Le serveur DNS permet de distribuer des adresses IP aux machines du réseau. Il peut le faire de manière statique ou dynamique, en attribuant une plage d'adresses IP à un réseau.

## Téléchargement

Retrouvez le script téléchargeable ici : [DNS Client](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dns/dns_intranet/dns_intranet_install_client.sh)

## Prérequis

- Avoir une machine virtuelle Debian 11 installée (voir [Installation-machine](../installation-machine.md))
- Avoir une connexion internet
- Avoir un accès `root` au serveur

## Installation

## Installation

Le script va réécrire le fichier /etc/bind/named.conf pour inclure les fichiers d'options, local et de zone par défaut.
Il va ensuite compléter le fichier local (/etc/bind/maned.conf.local) afin d'y insérer la zone pour les machines client et la zone des serveurs.
Puis, le script va créer deux fichier db correspondant aux zones et inclut pour les deux son IP (192.168.1.6) puis pour la zone serveurs, les serveurs de cette zone (dhcp, zabbix, ...)
Ensuite, il édite le fichier interfaces afin de fixer son adresse IP à 192.168.1.6 et édite le fichier /etc/default/named pour être en IPv4
Enfin, il redémarre les services bind9 et networking.