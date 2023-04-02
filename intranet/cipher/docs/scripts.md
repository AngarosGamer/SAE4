---
hide:
  - navigation
---
# Scripts Cipher

Cipher repose sur une multitude de scripts bash remplissant chacun un rôle précis sur l'installation d'un service de l'infrastucture.

## DHCP

Le DHCP permet de distribuer des adresses IP aux machines du réseau. Il peut le faire de manière statique ou dynamique, en attribuant une plage d'adresses IP à un réseau.
Nous l'utilisons pour attribuer des adresses IP aux serveurs virtuels de l'infrastructure de manière statique, et dynamique pour les postes de travail.

Il y a deux scripts pour le DHCP :

- [`dhcp_install_server.sh`](./scripts/dhcp/server.md) : Installation à faire sur le serveur DHCP (qui distribue les adresses IP)
- [`dhcp_install_client.sh`](./scripts/dhcp/client.md) : Installation à faire sur une machine cliente du DHCP (qui reçoit une adresse IP)

## DNS

## Firewall

## Installation-machine

## Intranet

## Journalisation

## Kerberos

## LDAP

## NFS (Serveur de fichiers)

## Serveur de bases de données

## Test

## Machines Virtuelles

## Zabbix