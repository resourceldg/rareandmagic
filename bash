#! /bin/bash

#bash script para hardening ubuntu 18.04

On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White
On_Yellow='\033[43m'      # Yellow
NC='\033[0m' # No Color

printf "${On_Cyan}         ${NC}\n"
printf "${On_White}    ${On_Yellow} ${On_White}    ${NC}\n"
printf "${On_Cyan}         ${NC}\n"

sleep 2

echo" 888
      888  888  888   8888\   /~~~8e      8888/
      888  888  888 8888          88   C888
      888  888  888 8888     888~-888  Y88b
      888  888  888 8888    888   888     8888
      888   88__88  8888__/ 8888_-888 \_8888/
       8888"
sleep 2

set -o xtrace #genera la traza de logs por salida de terminal


apt update -y #actualiza


#back up sshd_config
cp /etc/ssh/sshd_config /etc/ssh/backup.sshd_config

# create non-root user

adduser admin777 --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "admin777:5l776I!|/}[&4Gg" | sudo chpasswd
usermod -aG sudo admin777

# Exit script on Error
set -e

#totp auth setup
sed -i '1i auth required pam_google_authenticator.so' /etc/pam.d/sshd
sed -i '/^ChallengeResponseAuthentication[ \t]\+\w\+$/{ s//ChallengeResponseAuthentication yes/g; }' /etc/ssh/sshd_config
sudo apt install libpam-google-authenticator -y


#modifica el intervalo de tiempo inactivo de las sesiones

printf '\n%s\n' 'ClientAliveInterval 300' >>/etc/ssh/sshd_config

#comprueba solo una vez la session

printf '\n%s\n' 'ClientAliveCountMax 0' >>/etc/ssh/sshd_config

#permitir usuario

printf '\n%s\n' 'AllowUsers lucas lucas-TWH root ' >>/etc/ssh/sshd_config

#permitir acceso por clave publica

printf '\n%s\n' 'PubkeyAuthentication yes' >>/etc/ssh/sshd_config

#Desabilitar X11Fowarding

sed -i '/^X11Forwarding[ \t]\+\w\+$/{ s//X11Forwarding no/g; }' /etc/ssh/sshd_config


#generar nuevas hotkeys

printf '\n%s\n' 'MaxAuthTries 2' >>/etc/ssh/sshd_config

printf '\n%s\n' 'MaxSessions 3' >>/etc/ssh/sshd_config

printf '\n%s\n' 'HostKey /etc/ssh/ssh_host_ed25519_key' >>/etc/ssh/sshd_config

printf '\n%s\n' 'HostKey /etc/ssh/ssh_host_ed25519_key' >>/etc/ssh/sshd_config

#Change Default Ciphers and Algorithms

printf '\n%s\n' 'KexAlgorithms curve25519-sha256@libssh.org' >>/etc/ssh/sshd_config

printf '\n%s\n' 'Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr' >>/etc/ssh/sshd_config

printf '\n%s\n' 'Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr' >>/etc/ssh/sshd_config

# Regenerate Moduli
ssh-keygen -G moduli-2048.candidates -b 2048
ssh-keygen -T moduli-2048 -f moduli-2048.candidates
cp moduli-2048 /etc/ssh/moduli
rm moduli-2048


#test sshd

sshd -t

#restart ssh daemon

service sshd restart

su admin777

#agrega al final del archivo la clave publica al archivo authorized_keys

#cat publickey >>.ssh/authorized_keys 

#cambiar puerto por defecto

#sed -i '/^Port 22[ \t]\+\w\+$/{ s//Port 5633/g; }' /etc/ssh/sshd_config

#Deshabilitar root login

#sed -i '/^PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin no/g; }' /etc/ssh/sshd_config

#Deshabilitar password autentication

#sed -i '/^PasswordAuthentication[ \t]\+\w\+$/{ s//PasswordAuthentication no/g; }' /etc/ssh/sshd_config




