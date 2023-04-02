# Configurer le NFS coté client

## Prérequis

- Avoir un accès root sur la machine physique (ou virtuelle) sur laquelle lancer l'installation

## Téléchargement
Le script d'installation du NFS coté client est disponible ici : [Installer NFS client](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/nfs/nfs_install_client.sh)

## Installation
Pour installer le NFS coté client, il suffit de lancer le script `nfs_install_client.sh` téléchargé au-dessus en tant que `root` :
Il vous faut renseigner l'adresse ip du serveur de fichier sur lequel est installé le serveur NFS

```bash
utilisateur@machine:~# ./nfs_install_client.sh ip_serveur_nfs
```



