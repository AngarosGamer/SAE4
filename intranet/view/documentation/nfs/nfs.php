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
include("../navbar.viewpart.php");
?>
<div class="main-content">
    <h1>Documentation pour NFS</h1>

    <h2>Description</h2>
    <p>NFS est le serveur de fichier centralisé qui permet aux utilisateurs de l'infrastructure de recevoir tous les fichiers de leurs homedirs sur n'importe quelle machine du réseau</p>

    <h2>Dépendances</h2>
    <p>Le service apporté par NFS dépend d'autres services qu'il faudra mettre en place et paramétrer au préalable pour que NFS fonctionne</p>
    <ul>
        <li>Un serveur LDAP pour identifier et authentifier les utilisateurs</li>
        <li>Les autorisations suffisantes dans le pare-feu pour autoriser les connections</li>
    </ul>

    <h2>Organisation de l'installation</h2>
    <p>Il y a deux étapes pour l'installation, une sur le serveur et une sur le client<br>Voici les deux pages pour la documentation appropriée : </p>
    <ul>
        <li>
            <a href="">Le serveur</a>
        </li>
        <li>
            <a href="">Le client</a>
        </li>
    </ul>
</div>
</body>
</html>
