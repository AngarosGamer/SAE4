---
hide:
  - navigation
---
# Créer une nouvelle machine virtuelle

L'infrastructure de Cipher se base sur une architecture de machines virtuelles imbriquées, faisant utilisation de KVM comme support de virtualisation.

## Prérequis

- Avoir une machine physique (ou virtuelle) sur laquelle lancer l'installation
- Avoir configuré les réseaux voulus en avance
- Avoir une connexion internet et s'assurer que le NAT est bien configuré

## Téléchargement

Le script d'installation de la machine virtuelle est disponible ici : [Créer Machine Virtuelle](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/installation-machine/create_vm.sh)

## Installation

Pour installer une nouvelle machine virtuelle, il suffit de lancer le script `create_vm.sh` téléchargé au-dessus en tant que `root` :

```bash
utilisateur@machine:~# ./create_vm.sh <nom de la machine> <nombre de coeurs de CPU à allouer> <taille de la RAM à utiliser (en MBytes)> <taille du stockage (en Go)>
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
utilisateur@machine:~# chmod +x create_vm.sh
```

## Configuration

La machine virtuelle créée est une Debian 11, mais emploie des paramètres de configuration par défaut. Il est donc nécessaire de la configurer pour qu'elle soit utilisable et sécurisée.

Pour se connecter pour la première fois à la machine virtuelle, il faut lancer la console graphique.
Puis, se connecter avec les identifiants suivants :

- Utilisateur : `root`
- Mot de passe : `root`

### Sur un client

Si votre machine est une machine cliente, les étapes suivantes sont déjà inclues dans un script de post-installation, qui se charge de faire toute la configuration automatiquement; il suffit de lancer le script [`post_install.sh`](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/installation-machine/post-install.sh) en tant que `root` :

```bash
root@unassigned:~# chmod +x post_install.sh
root@unassigned:~# ./post_install.sh
```

### Sur un serveur

#### Changement du nom de la machine

Le nom par défaut de la machine sera "unassigned". Il est donc possible de le changer en utilisant la commande suivante :

```bash
root@unassigned:~# hostnamectl set-hostname <nom de la machine>
```

#### Changement du mot de passe de l'utilisateur `root`

Le mot de passe root par défaut est très peu sécurisé. Il est nécessaire de le changer pour garantir un niveau de sécurité suffisant.
Nous recommandons un mot de passe d'au moins 12 caractères, contenant des chiffres, des lettres majuscules et minuscules, ainsi que des caractères spéciaux.

```bash
root@machine:~# passwd
```

#### Ajout d'un compte utilisateur

Le compte root n'est à utiliser que pour des opérations d'administration. Il est donc nécessaire de créer un compte utilisateur pour pouvoir se connecter à la machine virtuelle et effectuer des actions de base qui ne nécessitent pas de privilèges particuliers.

```bash
root@machine:~# adduser <nom de l'utilisateur>
```

Il vous sera demander plusieurs informations, dont le mot de passe de cet utilisateur, son nom complet, son numéro de téléphone, etc.

#### Suppression du compte par défaut

Lors de l'installation, un compte par défaut est créé. Il est possible de le supprimer, son rôle étant uniquement lié à l'installation de la machine.

```bash
userdel -r setupaccount
```

### Configuration du réseau

La machine virtuelle créée est configurée pour utiliser le réseau `default` par défaut. Il est possible de la configurer pour utiliser un autre réseau en modifiant le fichier `/etc/network/interfaces` en tant que `root`:

```bash
root@machine:~# nano /etc/network/interfaces
```

Sur un serveur, il y a deux méthodes pour modifier son adresse IP :

- Utiliser le DHCP pour le serveur (sauf si c'est le serveur DHCP), qui lui attribuera une IP statique

Dans ce cas, utiliser le script [`dhcp_install_client.sh`](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/dhcp/dhcp_install_client.sh) pour configurer la machine pour qu'elle utilise le serveur DHCP.

- Utiliser une IP statique directement, auquel cas il faut modifier le fichier directement

Pour continuer, il faudra connaître le nom de l'interface réseau à modifier. Pour cela, il faut utiliser la commande `ip a` pour lister les interfaces réseau disponibles :

```bash
root@machine:~# ip a
```

Avec le nom de l'interface, il est possible de modifier le fichier `/etc/network/interfaces` pour configurer l'interface réseau :

```bash
allow-hotplug <nom de l'interface>
iface <nom de l'interface> inet static
    address <adresse IP>
    netmask <masque de sous-réseau>
    gateway <adresse IP de la passerelle>
```

## Changement de carte réseau

Comme nous travaillons dans une machine virtuelle, il faut changer la carte réseau pour ne plus utiliser le réseau virtuel `default`, mais le réseau voulu (DMZ, Serveurs, Machines, etc.).

Dans la console virt-manager, cliquer sur l'icône ampoule en haut à gauche, et trouver la carte réseau à modifier (NIC :xx:xx:xx). Cliquer dessus, et changer le "Network Source" à celui voulu.

Appliquer ces changements en cliquant sur "Apply".

Dernièrement, il faut redémarrer la machine virtuelle pour que les changements soient pris en compte.

## Finalisation

Après le reboot de la machine virtuelle, la nouvelle configuration devrait être prise en compte. Pour le vérifier, soit connectez vous avec le nouveau compte utilisateur, soit connectez vous en tant que `root` et vérifiez que le nom de la machine est bien celui voulu.

Il faut aussi que la machine ait une connexion internet qui marche. Pour cela il est possible de pinguer un serveur DNS (google par exemple) :

```bash
utilisateur@nom_machine:~# ping google.fr
```

Si tout est bon, le ping devrait marcher, sinon se référer à la section "Troubleshooting".
