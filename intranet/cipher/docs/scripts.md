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
Le DNS permet principalement de résoudre les noms de domaine en adresses IP pour faciliter l'accès aux sites web, et aussi aux différentes machines et serveurs de l'infrastructure.
Notre architecture comporte deux serveurs DNS, le premier pour la dmz, et le second pour le reste de l'infrastructure, c'est ce dernier qui va notamment être utilisé pour fournir les adresse IP correspondant aux noms de domaines demandés par les machines client.

Il y a donc trois scripts pour le DNS :
- [`dns_intranet_install_server.sh`](./scripts/dns/server_intranet.md) : Installation à faire sur le serveur DNS du réseau interne
- [`dns_intranet_install_client.sh`](./scripts/dns/client.md) : Installation à faire sur une machine cliente
- [`dns_dmz_install_server.sh`](./scripts/dns/server_dmz.md) : Installation à faire sur le serveur DNS de la DMZ

## Firewall

## Machines Virtuelles

L'architecture cipher se base sur des machines virtuelles, qui sont des machines virtuelles qui tourneront sur un serveur physique. A cet effet, il est nécessaire de mettre en place un script d'installation de machines virtuelles.

Il existe plusieurs scripts pour la mise en place de machines virtuelles :

- [`create_vm.sh`](./scripts/vm/create.md) : Création d'une machine virtuelle
- [`post-install.sh`](./scripts/vm/post-install.md) : Installation automatique de la machine virtuelle après sa création
- [`make-preseed-iso.sh`](./scripts/vm/preseed-iso.md) : Avancé - Création d'un fichier ISO contenant un fichier de configuration pour l'installation automatique d'une machine virtuelle

## Intranet

## Journalisation

## Kerberos

## LDAP

## NFS (Serveur de fichiers)

## Serveur de bases de données

## Test

## Zabbix