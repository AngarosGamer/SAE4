---
hide:
  - navigation
---
# Preseed de l'ISO

Le preseed est un fichier de configuration qui permet de configurer automatiquement une machine virtuelle lors de son installation. Il est possible de configurer le preseed de l'ISO de Debian afin de configurer automatiquement la machine virtuelle lors de son installation.
A l'aide d'un script, il est possible de passer d'un ISO normal à un ISO préconfiguré avec les paramètres précis qui correspondent à notre installation.

## Avertissements

Ce fichier et script est avancé, et nécessite une certaine connaissance de l'installation de Debian. Il est conseillé de ne pas modifier ce fichier si vous n'êtes pas sûr de ce que vous faites, et de lire la documentation de Debian avant de l'utiliser.

## Téléchargement

Le fichier de preseed que nous utilisons est disponible ici : [Preseed de l'ISO](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/installation-machine/preseed.cfg)
Le script permettant de passer d'un ISO normal à l'ISO préconfiguré est disponible ici : [Script de préconfiguration de l'ISO](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/installation-machine/make-preseed-iso.sh)

## Utilisation

Une fois le script téléchargé, il est possible de  l'utiliser pour créer un ISO préconfiguré. Pour cela, il suffit de lancer le script `make-preseed-iso.sh` téléchargé au-dessus en tant que `root`, dans le même répertoire que l'ISO de Debian et que le fichier de preseed :

```bash
root@machine:~# ./make-preseed-iso.sh </chemin/vers/iso/debian.iso>
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x make-preseed-iso.sh
```

Le script va alors créer un nouveau fichier ISO préconfiguré, dans le même répertoire que l'ISO de Debian. Il sera possible de l'utiliser pour installer une machine virtuelle avec les paramètres de configuration du fichier de preseed.
