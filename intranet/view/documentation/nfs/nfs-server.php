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
</div>
