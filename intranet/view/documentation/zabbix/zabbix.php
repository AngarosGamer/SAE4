<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/design/css/style.css" />
    <link rel="stylesheet" href="/design/css/navbar.css" />
    <link rel="stylesheet" href="/design/css/footer.css" />
    <title>Intranet Cipher</title>
</head>
<body>
<?php
include("../../navbar.viewpart.php");
?>
<div class="main-content">
    <h1>Documentation pour Zabbix</h1>

    <h2>Description</h2>
    <p>Zabbix est un outil puissant pour la surveillance du réseau.</p>

    <h2>Dépendances</h2>
    <p>Le service de Zabbix dépend d'une base de données MariaDB, elle est installée via le script d'installation.</p>

    <h2>Organisation de l'installation</h2>
    <p>L'installation de Zabbix se fait en une seule étape sur son serveur dédié et requiert d'une part d'utiliser un script automatisé qui va préparer le système pour accueillir Zabbix, installer le logiciel, et préparer la configuration générale. Dans un deuxième temps, une opération manuelle sera nécessaire pour terminer la configuration et mettre en place le reste du logiciel.</p>

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

    <p>Zabbix sera ensuite téléchargé et installé à la version 6.4, stable</p>
    <pre>
        <code class="language-bash">
wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb
dpkg -i zabbix-release_6.4-1+debian11_all.deb
apt update
        </code>
    </pre>

    <p>Il manque alors quelques packages à installer pour Zabbix, effectués par la commande</p>

    <pre>
        <code class="language-bash">
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y
        </code>
    </pre>

    <p>Puis la mise en place du serveur de bases de données MariaDB</p>

    <pre>
        <code class="language-bash">
apt -y install mariadb-server
systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb
        </code>
    </pre>


    <p>On va modifier les paramètres de sécurité de MariaDB pour demander un mot de passe</p>
    <p>Pour cette partie, il faut utiliser les informations suivantes : </p>

    <pre>
        <code class="language-bash">
mysql_secure_installation

Enter current password for root (enter for none): Appuyer sur Entrer
Switch to unix_socket authentication [Y/n] y
Change the root password? [Y/n] y
New password: <Un mot de passe sécurisé>
Re-enter new password: <Un mot de passe sécurisé>
Remove anonymous users? [Y/n]: Y
Disallow root login remotely? [Y/n]: Y
Remove test database and access to it? [Y/n]:  Y
Reload privilege tables now? [Y/n]:  Y
        </code>
    </pre>

    <p>Reste plus qu'à créer la base et la remplir avec les tables destinées à Zabbix</p>
    <p>Cette étape demandera à l'utilisateur de rentrer le mot de passe à utiliser pour la base de données, il faut utiliser celui renseigné à l'étape précédente.</p>
    <p>Pour la dernière commande d'initialisation, elle peut prendre du temps. Il ne faut pas s'en inquiéter et laisser tourner le script</p>

    <pre>
        <code class="language-bash">
apt -y install mariadb-server

zcat  /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p"$dbPassword" zabbix
        </code>
    </pre>

    <p>La ligne suivante permet à MariaDB de mettre à jour le mot de passe de Zabbix</p>

    <pre>
        <code class="language-bash">
"DBPassword=$dbPassword" >> /etc/zabbix/zabbix_server.conf
        </code>
    </pre>

    <p>Le script se chargera alors de lancer le serveur Zabbix et ses composants</p>

    <pre>
        <code class="language-bash">
systemctl restart zabbix-server zabbix-agent
systemctl enable zabbix-server zabbix-agent
systemctl status zabbix-server zabbix-agent
        </code>
    </pre>

    <p>Comme Zabbix fonctionne sous forme de site web, il faut aussi lancer le serveur web apache</p>

    <pre>
        <code class="language-bash">
systemctl restart apache2
systemctl enable apache2
systemctl status apache2
        </code>
    </pre>

    <p>L'installation du script est alors terminée ! Zabbix est maintenant installé.</p>

    <h2>Etapes Manuelles</h2>

    <p>Maintenant que le script a terminé son execution, Zabbix devrait être configuré et en train de tourner sur le serveur.</p>
    <!-- TODO Remplacer avec la réelle addresse du serveur Zabbix -->
    <p>Le panneau de configuration est accessible à l'adresse <a href="http://<ip du serveur>/zabbix">http://&lt;ip du serveur&gt;/zabbix</a></p>

    <p>L'IP demandée devrait être écrite à la fin de l'éxécution du script.</p>

    <p>Une fois le site ouvert, il faut passer les étapes jusqu'à la configuration de la base de données.
    <br>Sur cette étape, il faut entrer en mot de passe celui sélectionné pendant les étapes du script.</p>

    <p>On peut ensuite passer les autres étapes sans changements</p>

    <p>Une fois ceci terminé, il suffira de se connecter à Zabbix en utilisant les informations suivantes :</p>
    <ul>
        <li>Utilisateur : Admin</li>
        <li>Mot de passe : zabbix</li>
    </ul>

</div>
<script src="/design/js/jsPrism.js"></script>
<?php
include("../../footer.viewpart.php");
?>
</body>
</html>
