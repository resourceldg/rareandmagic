# RareandMagic: Site Reliability Engineer

setup completo

ubuntu 18.04
latch
wordpress
ssh
bash script
google-autenticator
docker




# accesso ssh
-----------------------------------------------------------------------------------------------------------------------------

	1 sudo ssh  root@<ip> -p 22
	2 nano hard.sh
	3 chmod -R 777 hard.sh
	4 ./hard.sh
	5 google-authenticator

vinculamos con latch para generar totp

# escaneamos el QR y restarteamos el demonio sshd
aceptamos
-----------------------------------------------------------------------------------------------------------------------------

	6 service restart sshd
	en tu host local borramos la llave antigua
	7 ssh-keygen -f "/root/.ssh/known_hosts" -R "[66.97.43.98]:5633"
	8 volvemos a conectarnos
	9 sudo ssh  root@66.97.43.98 -p 5633
	ponemos la clave de verificacion generada por la app latch
	y luego el pass del servidor
	si entramos es porque ya tenemos el TOPt

	10 sudo admin777
	11 cd

# instalar docker
-----------------------------------------------------------------------------------------------------------------------------

        12 sudo apt-get install curl apt-transport-https ca-certificates software-properties-common
        13 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        14 sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        15 sudo apt update
        16 apt-cache policy docker-ce
        17 sudo apt install docker-ce
        18 sudo systemctl status docker
        19 sudo docker run hello-world
        20.0  sudo usermod -aG docker $(whoami)
        
# instalar docker compose 
-----------------------------------------------------------------------------------------------------------------------------
 
        20.1 sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	
	20.2 sudo chmod +x /usr/local/bin/docker-compose

        
# wordpress on paranoid mode
-----------------------------------------------------------------------------------------------------------------------------
 
 	21 git clone https://github.com/resourceldg/rareandmagic.git
        22 cd rareandmagic/wpmdocker
        23 add <idapp> and <secret> in docker-compose
        24 docker-compose up -d
        
ERRORES COMUNES 

algunos consejos de Docker en este momento
acceder al bash del contenedor: docker exec  -it <nombre del contenedor> bash
salir del contenedor sin romper la salida  CTRL + P + Q 


Error 01  de acceso a la base de datos por defecto
Nombre de la bd  wordpress
nombre de usuario root
pass mysqlroot
passdb mysqlroot
hostdb db
prefijo wp_


Error 02 NO CARGA DEL CSS
Solucion  dentro del contenedor wpm
entrar con:
docker exect -it wpm bash
instalar nano
sudo apt-get update 
sudo apt-get install vim nano
nano wp-config.php
        
# AGREGAR:
-----------------------------------------------------------------------------------------------------------------------------
 
        
        if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') $_SERVER['HTTPS']='on';


# ANTES DE LA LINEA:
-----------------------------------------------------------------------------------------------------------------------------
 
        
        require_once(ABSPATH . 'wp-settings.php');
        
        
        
SOLUCION PARCIAL LINK https://wordpress.stackexchange.com/questions/75921/ssl-breaks-wordpress-css
   
       
	

	25 COMPLETAR LA INSTALACION POR DEFECTO DE WORDPRESS
	26 GENERAR LA APP EN LATCH
	27 ACTIVAR PLUGGIN DE LATCH EN WP
	28 AGREGAR APPID Y SECRET CONFIGURACION EN HERRAMIENTAS DE LATCH 
	----ejecutar wordpres on paranoid mode.          
	25 sudo docker exec -it dbwpm ./install.sh

# salida exitosa!!
-----------------------------------------------------------------------------------------------------------------------------

	mysql: [Warning] Using a password on the command line interface can be insecure.
	Success! Triggers on MySQL
_____________________________________________________________________________________________________________________________



        



7


