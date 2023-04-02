#!/bin/bash

#Lancer ce script en root
#Si l'utilisateur lancant le script n'est pas root, cela affichera un message d'erreur 
if [ "$(id -u)" -ne 0 ]
then 
   echo "Ce script doit être lancé en tant que root"
   exit 1
fi

#Téléchargement et installation de la dernière version actuelle de phpldapadmin
wget http://ftp.de.debian.org/debian/pool/main/p/phpldapadmin/phpldapadmin_1.2.6.3-0.3_all.deb
apt -y install ./phpldapadmin_1.2.6.3-0.3_all.deb

#Modification du fichier de configuration de phpldapadmin
rm /etc/phpldapadmin/config.php
cat > /etc/phpldapadmin/config.php << 'EOF'
<?php
#  $config->custom->password['no_random_crypt_salt'] = true;
#  $config->custom->appearance['timezone'] = 'Australia/Melbourne';
#  $config->custom->appearance['tree'] = 'HTMLTree';
#  $config->custom->appearance['tree_height'] = 600;
#  $config->custom->appearance['tree_width'] = 250;
#  $config->custom->appearance['tree_icons'] = 4;
$config->custom->appearance['friendly_attrs'] = array(
        'facsimileTelephoneNumber' => 'Fax',
        'gid'                      => 'Group',
        'mail'                     => 'Email',
        'telephoneNumber'          => 'Telephone',
        'uid'                      => 'User Name',
        'userPassword'             => 'Password'
);

$servers = new Datastore();
$servers->setValue('server','name','Cipher LDAP Server');
$servers->setValue('server','host','ldap.cipher.com');
$servers->setValue('server','base',array('dc=cipher,dc=com'));
$servers->setValue('login','auth_type','session');
$servers->setValue('login','bind_id','cn=admin,dc=cipher,dc=com');
#  $servers->setValue('login','bind_id','cn=Manager,dc=example,dc=com');

EOF

#Creation du fichier de configuration apache pour phpldapadmin
cat > /etc/apache2/conf-available/phpldapadmin.conf << 'EOF'
Alias /phpldapadmin /usr/share/phpldapadmin/htdocs

<Directory /usr/share/phpldapadmin/htdocs>
  <IfModule mod_authz_core.c>
    Require all granted
  </IfModule>
</Directory>
EOF

#Affectation de la propriété de /usr/share/phpldapadmin/ à www-data
chown -R www-data: /usr/share/phpldapadmin/