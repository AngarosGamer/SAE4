# Connecter le client à l'annuaire LDAP

## Prérequis

- Avoir un accès root sur la machine physique (ou virtuelle) sur laquelle lancer l'installation

## Téléchargement
Le script d'installation du LDAP coté client est disponible ici : [Installer LDAP client](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/ldap/ldap_install_client.sh)

## Installation
Pour installer le LDAP coté client, il suffit de lancer le script `ldap_install_client.sh` téléchargé au-dessus en tant que `root` :

```bash
utilisateur@machine:~# ./ldap_install_client
```
Une premiere interface s'ouvrira afin de configurer nslcd, où vous devez choisir : 
- LDAP server:	ldap://192.168.1.7/	
- Distinguished name base:	dc=cipher,dc=com
- Activer le password, shadow et group grâce à la barre espace

Puis une seconde interface s'ouvrira et vous devez cocher "Create home directory on login" grâce à la barre espace

Une fois le serveur configuré, vous pourrez avoir accès aux compte répertorié dans l'annuaire.

## Test
Vous pouvez tester l'accès à l'annuaire en effectuant la commande shell : 
```bash
getent passwd
```
qui affichera en plus des comptes créés localement, les comptes distants de l'annuaire LDAP.