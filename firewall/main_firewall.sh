#!/bin/bash

# Script principal du firewall
# Va installer les dépendances nécessaires, lancer le firewall et le paramétrer pour se lancer au boot
# Utilise les scripts de configuration du firewall
#  - firewall_reset.sh                : Reset le firewall (supprime toutes les règles, repasse au )
#  - firewall_rules_forward.sh        : Règles de routage du routeur (connexions qui transitent par le routeur)
#  - firewall_rules_input.sh          : Règles d'entrée sur le routeur (connexions à destination du routeur)
#  - firewall_rules_output.sh         : Règles de sortie du routeur (connexions à partir du routeur)

# A utiliser en tant que root, sur le routeur principal, qui agit comme firewall

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Faire l'installation de nft si non installé
if [[ -f /usr/sbin/nft ]]; then
    echo "nft est déjà installé, passage à l'étape suivante"
else
    apt install nftables  || error "L'installation de nftables a échoué. Il est nécessaire de l'installer pour que le firewall fonctionne."
    exit 1
fi

# Lancer nftables et le paramétrer pour se lancer quand la machine boot + status
if [ "$(systemctl is-active --quiet nftables)" ]; then
    echo "nftables est déjà actif, passage à l'étape suivante"
else
    systemctl start nftables
    systemctl enable nftables
    systemctl status nftables
fi

# Installer le tracker des connexions si non installé
if [[ -f /usr/sbin/conntrack ]]; then
    echo "conntrack est déjà installé, passage à l'étape suivante"
else
    apt install conntrack || error "L'installation de conntrack a échoué. Il est nécessaire de l'installer pour que le firewall statefull fonctionne."
    exit 1
fi

# Installer le JDK de Java si non installé
if [[ -f /usr/bin/java ]]; then
    echo "Java est déjà installé, passage à l'étape suivante"
else
    apt install default-jdk || error "L'installation de Java a échoué. Il est nécessaire de l'installer pour que le firewall fonctionne."
    exit 1
fi

# Réinitialiser le firewall (vérification de l'existence du fichier)
if [[ -f ./firewall_reset.sh ]]; then
    source ./firewall_reset
else
    echo "Le fichier firewall_reset.sh n'existe pas, d'anciennes règles risques de persister. Veuillez le créer ou prendre la configuration de base et déposer le fichier dans le dossier firewall"
fi

# Règles de forward (vérification de l'existence du fichier)
if [[ -f ./firewall_rules_forward.sh ]]; then
  source ./firewall_rules_forward.sh
else
  echo "Le fichier firewall_rules_forward.sh n'existe pas, les règles de forward n'existeront pas. Veuillez le créer ou prendre la configuration de base et déposer le fichier dans le dossier firewall"
fi

# Règles d'entrée (vérification de l'existence du fichier)
if [[ -f ./firewall_rules_input.sh ]]; then
  source ./firewall_rules_input.sh
else
  echo "Le fichier firewall_rules_input.sh n'existe pas, les règles d'input n'existeront pas. Veuillez le créer ou prendre la configuration de base et déposer le fichier dans le dossier firewall"
fi

# Règles d'entrée (vérification de l'existence du fichier)
if [[ -f ./firewall_rules_output.sh ]]; then
    source ./firewall_rules_output.sh
else
    echo "Le fichier firewall_rules_output.sh n'existe pas, les règles d'output n'existeront pas. Veuillez le créer ou prendre la configuration de base et déposer le fichier dans le dossier firewall"
fi