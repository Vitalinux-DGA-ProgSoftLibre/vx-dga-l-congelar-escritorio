#!/bin/bash
#Diseñado por Arturo Martín
#Proyecto Piloto DGA

USUARIO=$(vx-usuario-grafico)
EJECUTOR=$(whoami)


vx-regenerar-entorno-escritorio-cli

<<FORMA_ANTERIOR
if [ -z $USUARIO ] ; then
	echo `date` "Usuario sin especificar. Salimos"
	exit 1
fi

HOMEUSUARIO="$(getent passwd | grep "${USUARIO}:" | cut -d":" -f6)"
if [ -z $HOMEUSUARIO ] ; then
	echo `date` "CONDIR: Home sin especificar. Salimos"
	exit 1
fi

if test "${EJECUTOR}" != "root" ; then
	echo "Se requiren privilegios de \"root\" para lanzar la Congelación ..."
	exit 1
fi

echo "$(date) - Proceso de congelación del Escritorio para el usuario: ${USUARIO} - ${EJECUTOR}" > ${HOMEUSUARIO}/info-congelacion-Escritorio.txt

if test -d /etc/skel/Escritorio ; then
	if rsync --delete -rl /etc/skel/Escritorio ${HOMEUSUARIO} ; then
		echo " --> OK: Se ha sincronizado el Escritorio del usuario ${USUARIO} ..." >> ${HOMEUSUARIO}/info-congelacion-Escritorio.txt
	else
		echo " --> ERROR: No se ha sincronizado el Escritorio del usuario ${USUARIO} ..." >> ${HOMEUSUARIO}/info-congelacion-Escritorio.txt
	fi
	chown -R ${USUARIO}.sudo ${HOMEUSUARIO}/Escritorio
fi
if test -d /etc/skel/Desktop ; then
	if rsync --delete -rl /etc/skel/Desktop ${HOMEUSUARIO} ; then
		echo " --> OK: Se ha sincronizado el Desktop del usuario ${USUARIO} ..." >> ${HOMEUSUARIO}/info-congelacion-Escritorio.txt
	else
		echo " --> ERROR: No se ha sincronizado el Desktop del usuario ${USUARIO} ..." >> ${HOMEUSUARIO}/info-congelacion-Escritorio.txt
	fi
	chown -R ${USUARIO}.sudo ${HOMEUSUARIO}/Desktop
fi

vx-eliminar-ficheros-conf-personales

FORMA_ANTERIOR

<<FORMA_ANTERIOR
# Eliminamos cualquier panel que se haya creado en el Escritorio que no es el Deseado
RUTA="/etc/skel/.config/lxpanel/Lubuntu/panels/panel"
if test -f ${RUTA} ; then
	for FICHERO in $(ls ${HOMEUSUARIO}/.config/lxpanel/Lubuntu/panels | grep -v panel) ; do
		# Eliminamos otros posibles paneles que se hayan generado
		rm -f ${HOMEUSUARIO}/.config/lxpanel/Lubuntu/panels/$FICHERO
	done
	if cp ${RUTA} ${HOMEUSUARIO}/.config/lxpanel/Lubuntu/panels/panel ; then
		echo " --> OK: Se ha congelado el panel inferior del usuario: ${USUARIO} ..." >> ${HOMEUSUARIO}/info-congelacion-Escritorio.txt
		chown ${USUARIO}.sudo ${HOMEUSUARIO}/.config/lxpanel/Lubuntu/panels/panel
	fi
fi

# Eliminamos cualquier configuración del Escritorio que se haya realizado
if test -f /usr/share/vitalinux/congelaescritorio/desktop-items-0.conf ; then
	if cat /usr/share/vitalinux/congelaescritorio/desktop-items-0.conf > ${HOMEUSUARIO}/.config/pcmanfm/lubuntu/desktop-items-0.conf ; then
		echo " --> OK: Se ha sincronizado las opciones del Escritorio del usuario ${USUARIO} ..." >> ${HOMEUSUARIO}/info-congelacion-Escritorio.txt
	else
		echo " --> ERROR: No se ha sincronizado las opciones del Escritorio del usuario ${USUARIO} ..." >> ${HOMEUSUARIO}/info-congelacion-Escritorio.txt
	fi
	chown ${USUARIO}.sudo ${HOMEUSUARIO}/.config/pcmanfm/lubuntu/desktop-items-0.conf
	for FICHERO in $(ls ${HOMEUSUARIO}/.config/pcmanfm/lubuntu | grep -v desktop-items-0.conf | grep -v pcmanfm.conf) ; do
		rm -f ${HOMEUSUARIO}/.config/pcmanfm/lubuntu/$FICHERO
	done
fi
#chown -R ${USUARIO} ${HOMEUSUARIO}/Escritorio/*
#chown -R ${USUARIO} ${HOMEUSUARIO}/Desktop/*
FORMA_ANTERIOR
