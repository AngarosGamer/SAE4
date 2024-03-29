#!/bin/bash

#Lancer ce script en root
#Si l'utilisateur lancant le script n'est pas root, cela affichera un message d'erreur 
if [ "$(id -u)" -ne 0 ]
then 
   echo "Ce script doit etre lancé en tant que root"
   exit 1
fi

# General
apt -y update
apt -y upgrade

#Installation des packets nécessaire
apt -y install 
#Saisi du mot de passe administrateur pas nécessaire dans l'interface graphique puis sélectionner "OK" 
apt -y install slapd

#Utilisation de l'outil de configuration debconf pour reconfigurer slapd
dpkg-reconfigure slapd
      ############################
      ## Configuration de slapd ##
      ############################

  #Selectionner "NON" pour pouvoir utiliser l'outil de reconfiguration
  #Pour le DNS, saisissez votre nom de domaine. e.g : cipher.com
  #Pour nom d’organisation votre nom d'entreprise. e.g : cipher
  #Entrez ensuite votre mot de passe administrateur
  #Choisissez non pour la suppression de la base de donnee lors de la purge du package slapd
  #Choisissez oui pour deplacer les anciens fichiers de bases de données

      ###############
      ##   LOG     ##
      ###############

#Modification du niveau de log que le serveur génère (de base il n'en génère aucun)
#Creer un fichier logLevel.ldif qui indique de changer le niveau de log à "stats" (le niveau conseillé pour le debbogage)
touch logLevel.ldif 
cat > logLevel.ldif << 'EOF'
dn: cn=config
changeType: modify
replace: olcLogLevel
olcLogLevel: stats
EOF
#Application des changements
ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f logLevel.ldif
#On indique au daemon de log rsyslog d'avoir un fichier de log séparé pour openldap
touch /etc/rsyslog.d/10-slapd.conf
cat > /etc/rsyslog.d/10-slapd.conf << 'EOF' 
local4.* /var/log/slapd.conf
EOF

#Restart de rsyslog pour appliquer les changements
systemctl restart rsyslog


      ##################
      ##   STRUCTURE  ##
      ##################

#Création du fichier structure.ldif afin de créer 3 branches : personnes, machines et serveurs
touch structure.ldif
cat > structure.ldif << 'EOF'
dn: ou=Personnes,dc=cipher,dc=com
objectclass: organizationalUnit
ou: Personnes
description: Employes de l entreprise

dn: ou=Machines,dc=cipher,dc=com
objectclass: organizationalUnit
ou: Machines
description: Poste de travail de l entreprise

dn: ou=Serveurs,dc=cipher,dc=com
objectclass: organizationalUnit
ou: Serveurs
description: serveur de l entreprise

EOF

#Ajout du fichier de configuration de la structure, le mot de passe de l'admin est requis
ldapadd -x -W -D "cn=admin,dc=cipher,dc=com" -H ldap://localhost -f structure.ldif