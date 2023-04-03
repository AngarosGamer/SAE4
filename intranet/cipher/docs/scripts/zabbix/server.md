---
hide:
  - navigation
---
# Mise en place de Zabbix

Zabbix est un outil de supervision d'infrastructure, qui permet de surveiller l'état de l'infrastructure, et d'être alerté en cas de problème.
Le script de mise en place de Zabbix permet de mettre en place un serveur Zabbix, qui sera utilisé pour surveiller l'infrastructure, il est semi-automatique, et nécessite une intervention manuelle pour la configuration de certains paramètres.

De plus, la fin de l'installation se fait sur l'interface web de Zabbix, de manière manuelle.

## Prérequis

- Un espace de stockage d'environ 5Go
- Un accès `root` à la machine virtuelle
- Une connexion internet active est nécessaire pour lancer ce script.

## Téléchargement

Le script de mise en place de Zabbix est disponible ici : [Installation Zabbix](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/zabix/zabbix_install_.sh)

## Utilisation

Pour installer le serveur zabbix, il suffit de lancer le script `zabbix_install.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./zabbix_install.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x zabbix_install.sh
```

## Configuration

Le script va commencer par installer tous les paquets nécessaires à l'installation de Zabbix, puis va configurer la base de données MySQL, et enfin va configurer Zabbix.

Pendant l'utilisation du script, on vous demandera de rentrer des informations, il s'agit du :

- Mot de passe de la base de données
- Paramètres de la base de données

Cette opération est à faire manuellement, même si les paramètres par défaut sont proposés et généralement acceptés.

Suite à cela le script se mettre en pause et demandera de compléter les conditions d'installation. Il faudra donc :

- Effectuer cette commande

```bash
root@machine:~# mysql -uroot
```

Puis exectuer la commande suivante pour créer la base de données :

```bash
MariaDB [(none)]> create database zabbix character set utf8mb4 collate utf8mb4_bin;
```

Puis exectuer la commande suivante pour créer l'utilisateur et donner les permissions :

```bash
MariaDB [(none)]> grant all privileges on zabbix.* to zabbix@localhost identified by <mot de passe>;
```

Une fois ces deux opérations terminées, poursuivre dans l'installation du script.

Attention, certaines étapes de l'installation sont longues.

Lorsque le script se termine, il demandera de se connecter à l'interface web de Zabbix, pour cela il faudra se rendre sur l'adresse `http://<adresse IP de la machine>/zabbix` et se connecter avec les identifiants par défaut :

- Identifiant : `Admin`
- Mot de passe : `zabbix`

## Configuration de Zabbix

Une fois connecté à l'interface web de Zabbix, il faudra configurer le serveur Zabbix, pour cela il faudra utiliser principalement les paramètres par défaut proposés par l'interface web.

Il faudra cependant entrer le mot de passe de la base de données, et le nom de la base de données, qui sont les mêmes que ceux rentrés lors de l'installation.

## Configuration des machines à superviser

Pour utiliser Zabbix, il faut pouvoir détecter les machines à superviser. Zabbix le permet de manière automatique, mais il doit être configuré pour cela.

### Découverte des machines

Pour que Zabbix puisse détecter les machines à superviser, il faut créer une (ou plusieurs) règles de découverte.

Pour cela, il faut se rendre dans la section `Collecte de données` de l'interface web de Zabbix, puis dans la sous-section `Découverte`.

Ici, cliquez sur le bouton `Créer une découverte` et entrez les informations suivantes :

- Nom : `<un nom approprié à la règle voulue, ex: dmz-discovery>`
- Proxy : `Aucun (sauf si vous utilisez un proxy)`
- Plage d'adresses IP : `<Une plage d'IP, ex: 192.168.0.0/24>`
- Intervalle d'actualisation : `1h`
- Vérifications :
  - `Ping ICMP`

Pour le reste, la configuration par défaut est suffisante.

Cliquez sur ajouter, et la règle de découverte est créée.

### Actions de découverte

Une fois la règle de découverte créée, il faut créer une action de découverte, qui permettra de créer les hôtes dans Zabbix et éventuellement d'effectuer les actions voulues.

Pour cela, il faut se rendre dans la section `Alertes` de l'interface web de Zabbix, puis dans la sous-section `Actions`, et enfin sur `Actions de découverte`.

Ici, cliquez sur le bouton `Créer une action` et entrez les informations suivantes :

- Nom : `<un nom approprié à l'action voulue, ex: dmz-action>`
- Conditions :
  - Type : `Test de découverte`
  - Opérateur : `égal`
  - Test de découverte : `<règle créée précédemment>`
- Opérations :
  - Opération : `Ajouter hôte`
  - Opération : `Ajouter au groupe d'hôtes`
    - Groupe d'hôtes : `<Linux Servers>`

Ajoutez cette action, et c'est terminé!

### Vérifications

Vous pouvez éventuellement relancer le service Zabbix sur le serveur pour prendre en compte les changements:

```bash
root@machine:~# systemctl restart zabbix-server
```

Au bout d'un certain temps (ce n'est pas instantané), vous pouvez également vérifier que les hôtes sont bien détectés dans l'interface web de Zabbix, dans la section `Hôtes` de l'interface web de Zabbix.
