# Configurer le NFS coté serveur

## Prérequis

- Avoir un accès root sur la machine physique (ou virtuelle) sur laquelle lancer l'installation

## Téléchargement
Le script d'installation du NFS coté client est disponible ici : [Installer NFS serveur](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/nfs/nfs_install_serveur.sh)

## Installation
Pour installer le NFS coté client, il suffit de lancer le script `nfs_install_serveur.sh` téléchargé au-dessus en tant que `root` :

```bash
serveur@machine:~# ./nfs_install_serveur.sh 
```

## Ajout client
Il vous faut à présent ajouter un client à qui le serveur NFS aura le droit de répondre afin de partager des répertoires.

## Téléchargement
Le script d'installation du NFS coté client est disponible ici : [Ajouter client NFS](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/nfs/nfs_add_client.sh)

## Installation
Pour installer le NFS coté client, il suffit de lancer le script `nfs_add_client.sh` téléchargé au-dessus en tant que `root` :
Il vous faudra renseigné l'addresse ip du client à laquelle le serveur sera autorisé à répondre.

```bash
serveur@machine:~# ./nfs_add_client.sh 
```

## Test
Après le reboot, vous verrez le homedir des utilisateurs de la machines cliente être montés sur le serveur de fichiers