# Paquete DEB vx-dga-l-congelar-escritorio
Paquete encargado de la Congelación del Escritorio (*Entorno LXDE*), borrando todos aquellos elementos que difieren respecto al directorio patrón **/etc/skel/Escritorio**,  manteniendo un aspecto del Escritorio fijo.  En concreto, durante la sesión el usuario podrá alterar el Escritorio a su gusto, pero al cerrar sesión, haciendo uso de un script de **lightdm** que se ejecuta en ese momento, se recompondrá dicho Escritorio.

La configuración del Escritorio LXDE se verá alterada igualmente ya que al cerrar sesión se restablecerán los parámeros de configuración iniciales.

# Usuarios Destinatarios

Tod@s aquell@s que deseen percibir que los elementos y aspecto del Escritorio no se me alterado en cada inicio de sesión.

# Aspectos Interesantes:

Haciendo uso de **Script Actions** se permitirá al usuario personalizar el patrón de Escritorio Congelado ubicado en **/etc/skel/Escritorio**.  En concreto se podrá llevar a cabo las siguientes acciones:

* Añadir elementos (*archivos, carpetas, lanzadores, etc.*) al patrón de Escritorio Congelado
* Eliminar elementos del patrón de Escritorio Congelado
* Gestionar el Escritorio Congelado.  Para ello se abrirá el directorio patrón con permisos de **root** desde nuestro **explorador de archivos** (*en LXDE pcmanfm*)

# Como Crear o Descargar el paquete DEB a partir del codigo de GitHub
En caso de querer modificar y mejorar el paquete, será necesario crear de nuevo el paquete.  Para crear el paquete DEB será necesario encontrarse dentro del directorio donde localizan los directorios que componen el paquete.  Una vez allí, se ejecutará el siguiente comando (es necesario tener instalados los paquetes apt-get install debhelper devscripts):

```
apt-get install debhelper devscripts
/usr/bin/debuild --no-tgz-check -us -uc
```

En caso de no querer crear el paquete para tu distribución, si simplemente quieres obtenerlo e instalarlo, puedes hacer uso del que está disponible para Vitalinux (*Lubuntu 14.04*) desde el siguiente repositorio:

[Respositorio de paquetes DEB de Vitalinux](http://migasfree.educa.aragon.es/repo/Lubuntu-14.04/STORES/base/)

# Como Instalar el paquete vx-dga-l-*.deb:

Para la instalación de paquetes que estan en el equipo local puede hacerse uso de ***dpkg*** o de ***gdebi***, siendo este último el más aconsejado para que se instalen de manera automática también las dependencias correspondientes.
```
gdebi vx-dga-l-*.deb
```

