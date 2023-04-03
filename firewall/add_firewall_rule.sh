#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]
  then echo "Ce script doit être utilisé en tant que root pour avoir les permissions nécessaires d'installation"
  exit
fi
echo "Ce script permet d'ajouter une règle simple au firewall. Pour les règles complexes, utilisez le script firewall_rules_forward ou firewall_rules_input"
echo "Les règles marquées par * sont obligatoires"
read -rp '*Chaine de règles ? [forward, input] : ' mode
read -rp '*Type de règle ? [udp, tcp, icmp] : ' type
read -rp 'Port source ? [0-65535] (x si aucun) : ' sport
read -rp 'Port destination ? [0-65535] (x si aucun) : ' dport
read -rp 'Addresse source ? [xxx.yyy.zzz.ttt] (x si aucune) : ' saddr
read -rp 'Addresse destination ? [xxx.yyy.zzz.ttt] (x si aucune) : ' daddr
read -rp '*Action  ? [accept, drop, reject] : ' action

if [ "$mode" == "forward" ] || [ "$mode" == "input" ]
then
  echo "Réussite : chaine de règle valide"
else
  echo "Erreur : chaine de règle invalide"
  exit
fi

if [ "$type" == "udp" ] || [ "$type" == "tcp" ] || [ "$type" == "icmp" ]
then
  echo "Réussite : type de règle valide"
else
  echo "Erreur : type de règle invalide"
  exit
fi

if [ "$action" == "drop" ] || [ "$action" == "accept" ] || [ "$action" == "reject" ]
then
  echo "Réussite : action valide"
else
  echo "Erreur : action invalide"
  exit
fi

nft "add rule filter mode '$mode' '$type' ip sport '$sport' ip dport '$dport' ip saddr '$saddr' ip daddr '$daddr' action '$action'"
