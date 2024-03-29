#!/bin/bash
if [[ "$#" -ne 3 ]];
then
    echo "Il faut renseigner les arguments suivant : nom  uid  gid"
    echo "Exemple de commande :"
	echo "./ldap_add_user dunandau 1001 1001 "
else
#Lancer ce script en root
#Si l'utilisateur lancant le script n'est pas root, cela affichera un message d'erreur 
if [ "$(id -u)" -ne 0 ]
then 
   echo "Ce script doit être lancé en tant que root"
   exit 1
fi

#Creation du fichier ldif pour la création d'un utilisateur
cat << EOF > "$1.ldif"
dn: cn=$1,ou=Personnes,dc=cipher,dc=com
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: $1
uid: $1
uidNumber: $2
gidNumber: $3
homeDirectory: /home/$1
loginShell: /bin/bash
gecos: $1
userPassword: $1
shadowLastChange: 0
shadowMax: -1
shadowWarning: 0

EOF

#Ajout de l'utilisateur, le mot de passe de l'admin sera requis
ldapadd -x -W -D "cn=admin,dc=cipher,dc=com" -f $1.ldif
fi

#Après s'être connecté une premiere fois avec le mot de passe de base qui est son login,
#l'utilisateur sera invité à changer son mot de passe et à se reconnecter