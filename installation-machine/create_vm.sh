#!/bin/bash
if [ "$#" -ne 4 ];
then
	echo "Il faut renseigner les arguments suivants : nom cpus memoire disque"
	echo "Exemple de commande :"
	echo "./create_vm routeur_cipher 2 2048 3"
else
	virt-install 																\
	--name="$1"																	\
	--vcpus="$2"  																\
	--memory="$3" 																\
	--cdrom=/machines/auto-install/preseed-debian-11.6.0-amd64-netinst.iso		\
	--disk size="$4"															\
	--os-variant=debiantesting													\
	--os-type=linux																\
	--network=default															\
	--accelerate
fi
