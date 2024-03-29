#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Mettre à jour les packages / installer les packages LDAP
apt update
apt -y install  libpam-ldapd libnss-ldapd ldap-utils nslcd

# Dans la configuration, choisir :
  #LDAP server:	ldap://192.168.1.7/	(not the default)
  #Distinguished name base:	dc=cipher,dc=com	(not the default)
  #Activer le password, shadow et group grâce à la barre espace

 
# Authentification par LDAP dans le service PAM
pam-auth-update
#Activer "Create home directory on login" en utilisant "espace"

systemctl restart nslcd
systemctl restart nscd
# Reboot pour sauvegarder les changements
reboot