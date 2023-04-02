---
hide:
  - navigation
---
# DNS Intranet Serveur

Le serveur DNS permet de distribuer des adresses IP aux machines du réseau. Il peut le faire de manière statique ou dynamique, en attribuant une plage d'adresses IP à un réseau.

## Téléchargement

Retrouvez le script téléchargeable ici : [DNS Serveur](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dns/dns_intranet/dns_intranet_install_server.sh)

## Prérequis

- Avoir une machine virtuelle Debian 11 installée (voir [Installation-machine](../installation-machine.md))
- Avoir une connexion internet
- Avoir un accès `root` au serveur

## Installation

Pour installer le serveur DNS de l'intranet, il suffit de lancer le script `dns_intranet_install.sh` téléchargé au-dessus en tant que `root` :

```bash
utilisateur@machine:~# ./dns_intranet_install_client.sh
```

Votre serveur est maintenant configurée