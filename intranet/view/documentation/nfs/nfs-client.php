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
    <h1>Documentation pour NFS coté client</h1>

    <h2>Description</h2>
    <p>Le client est la machine d'un utilisateur, qui va utiliser les services de NFS (et son serveur associé) afin de récupérer automatiquement le homedir de son utilisateur quand celui-ci se connecte. Cette configuration par NFS permettra aux utilisateurs de retrouver leurs documents peu importe la machine utilisée pour travailler sur le réseau</p>

    <h2>Script d'installation</h2>
    <p>Le script <a href="../../../nfs/nfs_install_client">nfs_install_client</a> peut être téléchargé et utilisé afin de mettre automatiquement le système en place pour un utilisateur</p>

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

    <p>Une fois le script lancé sur un shell root, il nous faut installer les packages nécessaires au client</p>

    <code class="language-bash">
        apt -y install nfs-common
    </code>

    <p>Nous allons ensuite monter notre homedir local sur le serveur NFS</p>
    <code class="language-bash">
        mount 192.168.128.4:/home /home
    </code>

    <p>Pour cette dernière étape, nous demandons à l'OS d'aller chercher le /home lorsque le systeme boot, sur le serveur NFS distant se trouvant à l'addresse 192.168.128.4 </p>
    <code class="language-bash">
        "192.168.128.4:/home   /home   nfs  noauto,x-systemd.automount   0  0" >> /etc/fstab
    </code>
</div>
<script src="/design/js/jsPrism.js"></script>
</body>
</html>
