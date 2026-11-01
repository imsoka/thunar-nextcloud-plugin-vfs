# Plugin de Thunar para Nextcloud

Plugin de Thunar que muestra y gestiona los archivos virtuales de la carpeta de Nextcloud. Su vocabulario describe el estado de cada archivo tal como lo ve el usuario.

## Estados

**Solo nube**:
Archivo virtual cuyo contenido no está en el equipo; solo existe su marcador y se descarga al abrirlo o al hidratarlo.
_Avoid_: dehidratado, online-only

**Local**:
Archivo virtual cuyo contenido ya está descargado en el equipo.
_Avoid_: hidratado, disponible sin conexión

**Atascada**:
Hidratación de un archivo en curso que no avanza durante el tiempo máximo permitido. El usuario recibe un aviso; el archivo sigue mostrándose como solo nube.
_Avoid_: colgada, bloqueada
