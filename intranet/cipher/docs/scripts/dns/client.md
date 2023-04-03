---
hide:
  - navigation
---
# DNS Client

Le script d'installation du client DNS permet de configurer une machine pour qu'elle utilise le serveur DNS (voir [DNS Server](server_intranet.md)). Il est à installer sur chaque machine cliente du réseau.

## Téléchargement

Retrouvez le script téléchargeable ici : [DNS Client](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dns/dns_intranet/dns_intranet_install_client.sh)

## Prérequis

- Avoir une machine virtuelle Debian 11 installée (voir [Installation-machine](../vm/create.md))
- Avoir une connexion internet
- Avoir un accès `root` au serveur

## Installation

Pour installer le DNS coté client, il suffit de lancer le script `dns_intranet_install_client.sh` téléchargé au-dessus en tant que `root` :

```bash
utilisateur@machine:~# ./dns_intranet_install_client.sh
```

Votre machine est maintenant configurée
