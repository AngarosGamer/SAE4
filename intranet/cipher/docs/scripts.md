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

## Pare-feu

Le pare-feu permet de filtrer les connexions entrantes et sortantes des machines de l'infrastructure. Il permet de bloquer les connexions entrantes et sortantes non autorisées, et de limiter les connexions sortantes à un certain nombre de connexions par seconde.
C'est un outil indispensable pour sécuriser l'infrastructure.

Nous avons plusieurs scripts pour le pare-feu, dont un principal permettant de tout mettre en place :

- [`main_firewall.sh`](./scripts/firewall/install.md) : Installation du pare-feu (et toutes les règles associées)

Autres scripts individuels :

- [`firewall_reset.sh`](./scripts/firewall/reset.md) : Réinitialisation du pare-feu
- [`firewall_rules_forward`](./scripts/firewall/forward.md) : Configuration des règles de paquet transitoires
- [`firewall_rules_input`](./scripts/firewall/input.md) : Configuration des règles de paquet entrants
- [`firewall_rules_output`](./scripts/firewall/output.md) : Configuration des règles de paquet sortants
- [`add_firewall_rule`](./scripts/firewall/add.md) : Ajout d'une règle de pare-feu

## Machines Virtuelles

L'architecture cipher se base sur des machines virtuelles, qui sont des machines virtuelles qui tourneront sur un serveur physique. A cet effet, il est nécessaire de mettre en place un script d'installation de machines virtuelles.

Il existe plusieurs scripts pour la mise en place de machines virtuelles :

- [`create_vm.sh`](./scripts/vm/create.md) : Création d'une machine virtuelle
- [`post-install.sh`](./scripts/vm/post-install.md) : Installation automatique de la machine virtuelle après sa création
- [`make-preseed-iso.sh`](./scripts/vm/preseed-iso.md) : Avancé - Création d'un fichier ISO contenant un fichier de configuration pour l'installation automatique d'une machine virtuelle

## Intranet

## Journalisation

La journalisation permet de stocker les logs des différents services de l'infrastructure. Nous utilisons un serveur de journalisation pour stocker les logs de tous les autres serveurs dans un espace de stockage centralisé.

Il y a deux scripts pour la journalisation :

- [`journald_install_server.sh`](./scripts/journalisation/server.md) : Installation à faire sur le serveur de journalisation
- [`journald_install_client.sh`](./scripts/journalisation/client.md) : Installation à faire sur une machine cliente

## Kerberos

Kerberos est un outil de sécurité qui permet d'authentifier les utilisateurs. Il est utilisé pour l'authentification des utilisateurs sur les machines virtuelles, et pour l'authentification des utilisateurs sur les serveurs, et pour NFS.

Nous avons 2 scripts pour le Kerberos :

- [`kerberos-server.sh`](./scripts/kerberos/server.md) : Installation à faire sur le serveur Kerberos
- [`kerberos-client.sh`](./scripts/kerberos/client.md) : Installation à faire sur une machine cliente

## LDAP

Le LDAP est un annuaire de données, qui permet de stocker des informations sur les utilisateurs, les groupes, les machines, etc. Il est utilisé pour l'authentification des utilisateurs, et pour la gestion des groupes d'utilisateurs.

Nous avons 2 scripts pour le LDAP :

- [`ldap_install_server.sh`](./scripts/ldap/server.md) : Installation à faire sur le serveur LDAP
- [`ldap_install_client.sh`](./scripts/ldap/client.md) : Installation à faire sur une machine cliente

## NFS (Serveur de fichiers)

Le service NFS permet de partager des fichiers et des dossiers entre plusieurs machines. Il est utilisé pour partager des fichiers entre les machines virtuelles et le serveur NFS qui contient ces fichiers.

C'est un outil utile pour pouvoir changer de poste de travail et continuer à travailler sur les mêmes fichiers.

Nous avons 2 scripts pour le NFS :

- [`nfs_install_server.sh`](./scripts/nfs/server.md) : Installation à faire sur le serveur NFS
- [`nfs_install_client.sh`](./scripts/nfs/client.md) : Installation à faire sur une machine cliente

## Serveur de bases de données

Le serveur de bases de données est un serveur qui permet de stocker des données dans des bases de données. Il est utilisé notamment dans le cadre d'un site web dynamique. Bien que nous n'en faisons pas utilisation, nous avons mis en place un script pour installer Postgres sur une machine de son choix.

Il n'y a qu'un script pour le serveur de bases de données :

- [`postgres_install.sh`](./scripts/postgres/server.md) : Installation à faire sur le serveur de bases de données

## Test

Afin de pouvoir tester l'infrastructure, nous avons mis en place des scripts à executer permettant de tester l'ensemble des services de l'infrastructure.

A cet effet, nous avons mis en place 2 scripts :

- [`test-connectivite.sh`](./scripts/test/connectivite.md) : Script de test pour la disponibilité des machines de l'infrastructure
- [`test-services.sh`](./scripts/test/services.md) : Script de test pour la disponibilité des services de l'infrastructure

## Zabbix

Zabbix est notre outil de surveillance du réseau. Il permet de surveiller l'état des machines, et de détecter les problèmes qui ont pu survenir.
C'es un outil puissant qui permettra de rapidement visualiser l'état du réseau.

Nous n'avons besoin que d'un script à executer sur le serveur Zabbix :

- [`zabbix_install.sh`](./scripts/zabbix/server.md) : Installation à faire sur le serveur Zabbix
