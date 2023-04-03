---
hide:
  - navigation
---
# Installer le pare-feu

Le pare-feu permet de filtrer les connexions entrantes et sortantes d'une machine. Il permet de bloquer les connexions entrantes et sortantes non désirées.
Ce script est le script principal qui permet d'installer le pare-feu (nftables) si ce n'est pas fait, et de configurer le pare-feu pour qu'il soit fonctionnel avec toutes les règles.

## Prérequis

- Une connexion internet active est nécessaire pour lancer ce script.
- Un accès `root` à la machine virtuelle

## Téléchargement

Le script d'installation du pare-feu est disponible ici : [Installation pare-feu](https://raw.githubusercontent.com/AngarosGamer/SAE4/main/firewall/main_firewall.sh)

## Utilisation

Pour installer le pare-feu, il suffit de lancer le script `main_firewall.sh` téléchargé au-dessus en tant que `root` :

```bash
root@machine:~# ./main_firewall.sh
```

Afin de faire tourner ce script, il sera possiblement nécessaire de lui donner les droits d'exécution :

```bash
root@machine:~# chmod +x main_firewall.sh
```

L'installation se fait cependant automatiquement sans configuration supplémentaire nécessaire. Il n'a pas vocation à recevoir d'autres modifications, ce script est conçu pour appeler d'autres scripts qui remplissent chacun une tâche dans la mise en place d'un groupe de règles du pare-feu.

## Références

- [Réinitialiser le pare-feu](reset.md) : Réinitialiser le pare-feu
- [Règle de `forward`](forward.md) : Règle de `forward`
- [Règle de `input`](input.md) : Règle de `input`
- [Règle de `output`](output.md) : Règle de `output`
