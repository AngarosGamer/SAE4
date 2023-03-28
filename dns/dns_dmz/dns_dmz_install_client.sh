#!/bin/bash

#Verfie si le script est lancé en tant que root
    if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être lancé en tant que root" 
    exit 1
    fi