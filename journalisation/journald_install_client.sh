#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi

# Install the remote journald packages
apt update
apt upgrade
apt -y install systemd-journal-remote

#Modification du fichier decrivant où nous devons envoyer les journaux
cat > /etc/systemd/journal-remote.conf << 'EOF'
ServerName=192.168.1.4
ServerPort=19532
EOF

# Mettre en marche le client des logs
systemctl enable systemd-journal-upload.service
reboot
# Ouverture du port 80 sur le pare-feu