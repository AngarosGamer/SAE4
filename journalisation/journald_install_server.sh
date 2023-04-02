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

#Modification de journal-upload.conf pour lui indiquer l'addresse ip et le port à utiliser
rm /etc/systemd/journald.conf
touch /etc/systemd/journald.conf
cat > /etc/systemd/journald.conf << 'EOF'
[Journal]
Storage=persistent
#Compress=yes
#Seal=yes
#SplitMode=uid
#SyncIntervalSec=5m
RateLimitIntervalSec=30s
RateLimitBurst=1000
#SystemMaxUse=
#SystemKeepFree=
#SystemMaxFileSize=
#SystemMaxFiles=100
#RuntimeMaxUse=
#RuntimeKeepFree=
#RuntimeMaxFileSize=
#RuntimeMaxFiles=100
#MaxRetentionSec=
#MaxFileSec=1month
#ForwardToSyslog=yes
#ForwardToKMsg=no
#ForwardToConsole=no
#ForwardToWall=yes
#TTYPath=/dev/console
#MaxLevelStore=debug
#MaxLevelSyslog=debug
#MaxLevelKMsg=notice
#MaxLevelConsole=info
#MaxLevelWall=emerg
#LineMax=48K
#ReadKMsg=yes
#Audit=no
ListenStream=192.168.1.4:19532
EOF

#Permission à systemd-journal-upload.service de start automatiquement au boot
systemctl restart systemd-journald

# Mettre en marche le serveur de logs
systemctl enable --now systemd-journal-remote.socket
systemctl enable systemd-journal-remote.service

reboot