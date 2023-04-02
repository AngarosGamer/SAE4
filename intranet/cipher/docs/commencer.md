---
hide:
  - navigation
---
# Commencer à mettre en place Cipher

L'installation de l'infrastructure de Cipher se fzit en plusieurs étapes, dans un ordre défini ici :

## Installation des machines virtuelles

Pour commencer à mettre en place Cipher, il faut mettre en marche les différentes machines qui vont tourner dans l'infrastructure. Pour cela, il faut suivre la documentation [Installation-machine](./scripts/vm/create.md).

### Mise en place d'un client

Si vous souhaitez mettre en place un client (poste de travail), un script peut être executé juste après l'installation de la machine virtuelle, qui mettra en place tous les paramètres de configuration, installera les paquets nécessaires pour être intégré dans l'infrastructure, et modifie les mots de passe par défaut.

Cette mise en place sera presque automatique, mais nécessite tout de même pour quelques étapes une intervention manuelle, principalement pour les paramètres de la machine.

### Mise en place d'un serveur

La mise en place d'un serveur est plus complexe, car il s'agit là de définir précisément la tâche que devra accomplir ce serveur en particulier.

Une fois le choix sur la tâche effectué, il faut suivre la documentation correspondante, à voir en choisissant le script associé dans la page [Scripts](./scripts.md).

La plupart des scripts de mise en place d'un serveur sont automatiques, mais certains nécessitent une intervention manuelle pour la configuration de certains paramètres. Se référer au script en question pour plus de détails.
