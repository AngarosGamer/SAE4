---
hide:
  - navigation
---
# Tester les services de l'infrastructure

L'infrastructure a quelques serveurs qui contiennent des services, accessibles par les machines internes. Certains sont critiques au bon fonctionnement de l'infrastructure, et il est donc important de pouvoir les tester.

Ce script permet de vérifier l'état de ces services pour savoir si ils sont disponibles ou non.

## Prérequis

- Une connexion internet active est nécessaire pour lancer ce script.

## Téléchargement

Le script de test des services est disponible ici : [Test des services](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/tests/test-services.sh)

## Utilisation

Pour utiliser ce script, il suffit de le lancer en tant qu'un utilisateur ayant les droits d'exécution :

Donner accès d'execution :

```bash
chmod +x test-services.sh
```

Lancer le script :

```bash
utilisateur@machine:~# ./test-services.sh
```

Ce script va tester un par un certains services pour lesquels les étapes de scripts sont définies, et afficher le résultat de chaque test.

Le script imprimera les résultats de ces tests sous la forme suivante :

```bash
Réponse de 192.168.1.8 - service DHCP semble en marche
```
