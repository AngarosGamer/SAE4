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

Le script va réécrire le fichier /etc/bind/named.conf pour inclure les fichiers d'options, local et de zone par défaut.
Il va ensuite compléter le fichier local (/etc/bind/maned.conf.local) afin d'y insérer la zone de la DMZ
Puis, le script va créer un fichier db pour la zone et y inclut les servers dns et web.
Ensuite, il édite le fichier interfaces afin de fixer son adresse IP à 192.168.0.4 et édite le fichier /etc/default/named pour être en IPv4
Enfin, il redémarre les services bind9 et networking.