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
    <p>Le script <a>Insérer script</a> peut être téléchargé et utilisé afin de mettre automatiquement le système en place pour un utilisateur</p>

    <h2>Etapes du script</h2>
    <p>Le script va suivre une procédure définie pour installer NFS sur la machine cliente : </p>
    <code class="language-bash">
        apt install yum
    </code>


</div>
<script src="/design/js/jsPrism.js"></script>
</body>
</html>
