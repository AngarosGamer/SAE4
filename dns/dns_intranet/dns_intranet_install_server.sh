#!/bin/bash
#Check if the user is root
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être lancé en tant que root" 
   exit 1
fi

#install bind9 packages

apt install bind9

#verify if bind9 is installed
if ! which bind9 > /dev/null; then
   echo -e "bind9 packages not installed, please advise your system administrator".
fi

