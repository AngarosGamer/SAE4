---
hide:
  - navigation
---
# Configurer l'annuaire LDAP

## Prérequis

- Avoir un accès root sur la machine physique (ou virtuelle) sur laquelle lancer l'installation

## Installer le serveur LDAP

### Téléchargement

Le script d'installation du LDAP coté client est disponible ici : [Installer LDAP server](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/ldap/ldap_install_server.sh)

### Installation

Pour installer le LDAP coté client, il suffit de lancer le script `ldap_install_server.sh` téléchargé au-dessus en tant que `root` :

```bash
server@machine:~# ./ldap_install_server.sh 
```

Une fenetre de configuration s'ouvrira et vous devrez séléctionner les éléments suivants :

- Non : pour pouvoir utiliser l'outil de configuration
- cipher.com : comme nom de domaine
- cipher : comme nom d'entreprise
- Entrez un mot de passe administrateur
- Non : pour ne pas supprimer la base en meme temps que le package slapd
- Oui : pour deplacer les anciennes bases de données

Votre serveur est maintenant configurer, avec 3 branches : Machines, Personnes et serveurs

### Test

Vous pouvez afficher chaque entrées de votre annuaire avec la commande slapcat, à ce niveau, elle ne devrait afficher que 3 paragraphes : un pour machines, serveurs et personnes.
Après avoir renseigné des utilisateurs avec le script ldap_add_user, vous verrez aparaitre des paragraphe supplémentaire correspondant à des comptes utilisateur sous le dn=Personnes.

## Ajouter des utilisateurs

### Téléchargement de ce script

Le script d'ajout d'utilisateur est disponible ici : [Ajouter utilisateur](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/ldap/ldap_add_user.sh)

### Utilisation

Pour ajouter un utilisateur, il suffit de lancer le script `ldap_add_user.sh` téléchargé au-dessus en tant que `root` :
Vous devez renseigner le nom du nouvel utilisateur, ainsi que l'uid et le gid que vous voulez lui attribuer :

```bash
server@machine:~# ./ldap_add_user.sh nom uid gid
```

Votre utilisateur est maintenant créé, vous pouvez le vérifier avec la commande slapcat vu précédemment.

Son passeword est son nom par défaut, lors de la connexion d'un client à ce compte, il sera invité à changer son mot de passe puis à se reconnecter.
