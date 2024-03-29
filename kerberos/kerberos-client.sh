#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Installer kerberos client et packets additionnels
apt install -y krb5-workstation krb5-libs krb5-auth-dialog krb5-user