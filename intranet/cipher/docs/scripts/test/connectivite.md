---
hide:
  - navigation
---
# Tester la disponibilité des machines de l'infrastructure

L'infrastructure est composée d'une multitude de machines, qui sont toutes connectées au réseau. Pour pouvoir communiquer entre elles, il faut donc que ces machines soient accessibles depuis n'importe quelle autre machine du réseau.

Afin de vérifier que les machines sont bien accessibles, il est possible de lancer un script qui va tester la connectivité entre toutes les machines de l'infrastructure, à l'aide d'une succession de pings.

## Prérequis

- Une connexion internet active est nécessaire pour lancer ce script.

## Téléchargement

Le script de test de connectivité est disponible ici : [Test de connectivité](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/tests/test-connectivite.sh)

## Utilisation

Pour utiliser ce script, il suffit de le lancer en tant qu'un utilisateur ayant les droits d'exécution :

Donner accès d'execution :

```bash
chmod +x test-connectivite.sh
```

Lancer le script :

```bash
utilisateur@machine:~# ./test-connectivite.sh
```

Ce script va tester toutes les addresses contenues dans le script lui-même, et afficher le résultat de chaque ping.

Dans le cas où le ping échoue, le script va afficher le message suivant :

```bash
192.168.0.0 : routeur-principal n'est pas joignable
```

Si le ping réussit, le script affichera le message suivant :

```bash
192.168.0.0 : routeur-principal est pas joignable
```

Pour ajouter une nouvelle machine à tester, il suffit d'ajouter une nouvelle ligne dans le tableau 'machine' du script, avec l'adresse IP de la machine à tester :

```bash
["<addresse IP de la machine>"]="<nom commun de la machine>"
```
