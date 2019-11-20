# Docker de Traccar Server 

_Cómo generar una imagen Docker con Traccar Server 4.6 para Raspberry Pi 3B (arquitectura ARM)_

### Pre-requisitos 📋

```
Raspberry Pi 3B
```
```
Sistema Operativo Raspbian Buster Lite (versión 26/09/2019) 
```

### Instalación 🔧

_Instalamos Docker en la Raspberry Pi_

```
sudo curl -fsSL get.docker.com | sed 's/buster/stretch/' | sh
```

_Comprobamos que se ha instalado bien_

```
docker -v
```
_Obtenemos el script para generar la imagen docker_

```
cd /home/pi/ && \
wget --directory-prefix=/home/pi https://raw.githubusercontent.com/rivasmjose/rpi-traccar/master/Dockerfile
```

_Generamos la imagen docker de traccar server para Raspberry Pi 3B_

```
docker build -t rivasmjose/rpi-traccar:4.6 .
```

_listamos las imágenes de docker de la Raspberry Pi para comprobar que se ha generado bien_

```
sudo docker images
```

## Ejecución ⚙️

_Creamos los puntos de montaje_

```
sudo mkdir -p /home/pi/docker/tracar/data
sudo mkdir -p /home/pi/docker/tracar/logs
```

_Copiamos el fichero de configuración traccar.xml_

```
wget --directory-prefix=/home/pi/docker/traccar/ \
https://raw.githubusercontent.com/rivasmjose/rpi-traccar/master/traccar/traccar.xml
```

_Creamos y arrancamos el contenedor con la imagen de traccar_

```
docker run -d --name=traccar --hostname=traccar --restart=always -p 5055:5055 \
-p 5055:5055/udp -p 8082:8082 -v /etc/timezone:/etc/timezone:ro \
-v /home/pi/docker/traccar/logs:/opt/traccar/logs:rw \
-v /home/pi/docker/traccar/data:/opt/traccar/data:rw \
-v /home/pi/docker/traccar/traccar.xml:/opt/traccar/conf/traccar.xml:ro \
rivasmjoseiz/traccar:4.6

```

_Esperamos unos minutos y ya podemos acceder a la url de traccar server_

```
http://ip_raspberry:8082/
```

