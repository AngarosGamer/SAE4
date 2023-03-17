<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/design/css/style.css" />
    <link rel="stylesheet" href="/design/css/navbar.css" />
    <title>Intranet Cipher</title>
</head>
<body>
<?php
include("../../navbar.viewpart.php");
?>
<div class="main-content">
    <h1>Documentation pour LDAP coté serveur</h1>

    <h2>Description</h2>
    <p>LDAP est l'annuaire permettant d'authentifier et de repertorier tous les utilisateurs et serveurs ainsi que leur role par exemple</p>

    <h2>Script d'installation</h2>
    <p>Le script <a href="">ldap_install_serveur</a> permet à l'administrateur d'installer et de configurer un serveur LDAP vide pour le moment</p>

    <h2>Etapes du script</h2>
    <p>Dans un premier temps, le script vérifie les permissions de l'utilisateur actuel, car il faut être root pour avoir les permissions d'installation</p>
    <pre>
        <code class="language-bash">
            if [ "$EUID" -ne 0 ]
            then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
            exit
            fi
        </code>
    </pre>

    <p>Ensuite nous créons un repertoire LDAP </p>
    <code class="language-bash">
        mkdir LDAP
        cd LDAP
    </code>

    <p>Nous allons pouvoir installer les packets nécessaires, attetion ici le mot de passe doit être renseigné dans l'interface graphique par l'administrateur</p>
    <code class="language-bash">
        apt-get policy slapd -y
        apt -y install slapd
        apt install sudo-ldap
    </code>

    <p>Voici comment créer un utilisateur non privilégié pour ldap</p>
    <code class="language-bash">
        useradd -r -M -d /var/lib/openldap -s /usr/sbin/nologin ldap
    </code>

    <p>Nous avons besoin d'installer les dépendances de ldap</p>
    <code  class="language-bash">
        apt install libsasl2-dev make libtool build-essential openssl \
        libevent-dev libargon2-dev sudo wget pkg-config wiredtiger \
        libsystemd-dev libssl-dev
    </code>

    <p>Maintenant nous télechargons la dernière version de OpenLDAP qui est actuellement la 2.6.4, puis l'extraire</p>
    <code  class="language-bash">
        wget https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.6.4.tgz
        tar xzf openldap-2.6.4.tgz
        cd openldap-2.6.4
    </code>

    <p>Une configuration est requise</p>
    <code  class="language-bash">
        ./configure --prefix=/usr --sysconfdir=/etc --disable-static \
        --enable-debug --with-tls=openssl --with-cyrus-sasl \
        --enable-dynamic --enable-crypt --enable-spasswd \
        --enable-slapd --enable-modules --enable-rlookups \
        --enable-backends=mod --disable-sql --enable-ppolicy=mod \
        --enable-syslog --enable-overlays=mod --with-systemd --enable-wt=no
    </code>

    <p>Nous allons maintenant installer les dépendances avec make depend ainsi que le package libperl-dev nécessaire mais pas installé par make depend</p>
    <code  class="language-bash">
        make depend
        apt install libperl-dev
    </code>

    <p>Maintenant nous compilons OpenLDAP</p>
    <code  class="language-bash">
        make
        make install
    </code>

    <p>Création d'un repertoire pour la base de données LDAP</p>
    <code  class="language-bash">
        mkdir /var/lib/openldap /etc/openldap/slapd.d
    </code>

    <p>Affectation des propriétés et des permissions aux repertoire LDAP</p>
    <code  class="language-bash">
        chown -R ldap:ldap /var/lib/openldap
        chown root:ldap /etc/openldap/slapd.conf
        chmod 640 /etc/openldap/slapd.conf
    </code>

    <p>Mise à jour du fichier slapd.service</p>
    <code  class="language-bash">
        mv /lib/systemd/system/slapd.service{,.old}
        cat > /etc/systemd/system/slapd.service << 'EOL'
        [Unit]
        Description=OpenLDAP Server Daemon
        After=syslog.target network-online.target
        Documentation=man:slapd
        Documentation=man:slapd-mdb

        [Service]
        Type=forking
        PIDFile=/var/lib/openldap/slapd.pid
        Environment="SLAPD_URLS=ldap:/// ldapi:/// ldaps:///"
        Environment="SLAPD_OPTIONS=-F /etc/openldap/slapd.d"
        ExecStart=/usr/libexec/slapd -u ldap -g ldap -h ${SLAPD_URLS} $SLAPD_OPTIONS

        [Install]
        WantedBy=multi-user.target
        EOL
    </code>

    <p>Nous copions maintenant le schema OpenLDAP</p>
    <code  class="language-bash">
        cp /usr/share/doc/sudo-ldap/schema.OpenLDAP  /etc/openldap/schema/sudo.schema
    </code>

    <p>Nous avons besoin de creer un fichier sudo.ldif</p>
    <code  class="language-bash">
        cat << 'EOL' > /etc/openldap/schema/sudo.ldif 
        dn: cn=sudo,cn=schema,cn=config
        objectClass: olcSchemaConfig
        cn: sudo
        olcAttributeTypes: ( 1.3.6.1.4.1.15953.9.1.1 NAME 'sudoUser' DESC 'User(s) who may  run sudo' EQUALITY caseExactIA5Match SUBSTR caseExactIA5SubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
        olcAttributeTypes: ( 1.3.6.1.4.1.15953.9.1.2 NAME 'sudoHost' DESC 'Host(s) who may run sudo' EQUALITY caseExactIA5Match SUBSTR caseExactIA5SubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
        olcAttributeTypes: ( 1.3.6.1.4.1.15953.9.1.3 NAME 'sudoCommand' DESC 'Command(s) to be executed by sudo' EQUALITY caseExactIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
        olcAttributeTypes: ( 1.3.6.1.4.1.15953.9.1.4 NAME 'sudoRunAs' DESC 'User(s) impersonated by sudo (deprecated)' EQUALITY caseExactIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
         olcAttributeTypes: ( 1.3.6.1.4.1.15953.9.1.5 NAME 'sudoOption' DESC 'Options(s) followed by sudo' EQUALITY caseExactIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
        olcAttributeTypes: ( 1.3.6.1.4.1.15953.9.1.6 NAME 'sudoRunAsUser' DESC 'User(s) impersonated by sudo' EQUALITY caseExactIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
        olcAttributeTypes: ( 1.3.6.1.4.1.15953.9.1.7 NAME 'sudoRunAsGroup' DESC 'Group(s) impersonated by sudo' EQUALITY caseExactIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
        olcObjectClasses: ( 1.3.6.1.4.1.15953.9.2.1 NAME 'sudoRole' SUP top STRUCTURAL DESC 'Sudoer Entries' MUST ( cn ) MAY ( sudoUser $ sudoHost $ sudoCommand $ sudoRunAs $ sudoRunAsUser $ sudoRunAsGroup $ sudoOption $ description ) )
        EOL
    </code>

    <p>Et maintenant nous mettons à jour la base de données slapd</p>
    <code  class="language-bash">
        mv /etc/openldap/slapd.ldif{,.bak}
        at > /etc/openldap/slapd.ldif << 'EOL'
        dn: cn=config
        objectClass: olcGlobal
        cn: config
        olcArgsFile: /var/lib/openldap/slapd.args
        olcPidFile: /var/lib/openldap/slapd.pid

        dn: cn=schema,cn=config
        objectClass: olcSchemaConfig
        cn: schema

        dn: cn=module,cn=config
        objectClass: olcModuleList
        cn: module
        olcModulepath: /usr/libexec/openldap
        olcModuleload: back_mdb.la

        include: file:///etc/openldap/schema/core.ldif
        include: file:///etc/openldap/schema/cosine.ldif
        include: file:///etc/openldap/schema/nis.ldif
        include: file:///etc/openldap/schema/inetorgperson.ldif
        include: file:///etc/openldap/schema/sudo.ldif
        #include: file:///etc/openldap/schema/ppolicy.ldif
        dn: olcDatabase=frontend,cn=config
        objectClass: olcDatabaseConfig
        objectClass: olcFrontendConfig
        olcDatabase: frontend
        olcAccess: to dn.base="cn=Subschema" by * read
        olcAccess: to *         
            by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" manage 
            by * none

        dn: olcDatabase=config,cn=config
        objectClass: olcDatabaseConfig
        olcDatabase: config
        olcRootDN: cn=config
        olcAccess: to * 
        by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" manage 
        by * none
        EOL
    </code>

    <p>Création de la première base de données utilisable, puis nous affectons sa propriété à l'utilisateur "ldap"</p>
    <code  class="language-bash">
        slapadd -n 0 -F /etc/openldap/slapd.d -l /etc/openldap/slapd.ldif
        chown -R ldap:ldap /etc/openldap/slapd.d
    </code>

    <p>Enfin, nous relancons systemd et nous demarrons le service OpenLDAP</p>
    <code  class="language-bash">
        systemctl daemon-reload
        systemctl enable --now slapd
    </code>

    
















</div>