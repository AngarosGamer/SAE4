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
    <h1>Documentation pour NFS coté serveur</h1>

    <h2>Description</h2>
    <p>Le serveur NFS est le serveur qui stockera les repertoires montés par les clients, afin de leur envoyer automatiquement le repertoire demandé quand l'utilisateur se connecte. Cette configuration par NFS permettra aux utilisateurs de retrouver leurs documents peu importe la machine utilisée pour travailler sur le réseau</p>

    <h2>Script d'installation</h2>
    <p>Le script <a href="../../../nfs/nfs_install_serveur">nfs_install_serveur</a> peut être téléchargé et utilisé afin de mettre automatiquement le serveur en place <br> Il faudra, en plus de ce script, utiliser le script <a href="">nfs_ajouter_client</a> pour chaque machine voulant être rajouté au systeme</p>

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

    <p>Ensuite, nous installons les packages nécessaires à l'installation du serveur NFS</p>
    <code class="language-bash">
        apt -y install nfs-kernel-server
    </code>

    <p>Puis, il faudra pour chaque machine devant être connectée au serveur de fichier, lancer le script <a href="">nfs_ajouter_client</a> avec comme parametre l'adresse IP de la machine cliente</p>
    <p>Il contient notamment cette ligne qui accepte la machine d'addresse IP indiqué, le paramètre no_root_squash permettant de retirer le squashing, ce qui permet au client root sur sa machine local de changer n'importe quels fichiers sur le serveur de fichier  </p>



</div>
