#!/bin/bash 
passwd= $(echo -e "odroid\n") #verified code but this patron is equivalent to instalation 
repeatwd=""
usergithub=""
passparse=""
wlanpasswd=""
timezone=""
ssid=""
email=""

# timezone del servidor "America/Argentina/Buenos_Aires"

read -s -p "ingrese su contrasenia del nueva para el usuario $(whoami): " repeatwd
echo -e "\n" 
read -s -p "ingrese contrasenia de la keygen ssh :" passparse
echo -e "Mostrando Timezones disponibles\n" 
#timedatectl list-timezones
read -p "ingrese timezone de su sevidor: " timezone
read -p "ingrese SSID de Wlan0: " ssid
read -s -p "ingrese su contrasenia de wifi:$ssid: " wlanpasswd
echo -e "\n" 
read -p "ingrese su mail asociado a github/gitlab: " email 
read -p "ingrese su usuario asociado a github/gitlab: " usergithub


#packeted basicos de instalacion
$passw | sudo -S apt-get update
$passw | sudo -S apt-get upgrade -y -f
$passw | sudo -S apt-get install vim -y
$passw | sudo -S apt-get install trickle   #limitador de velocidad 
$passw | sudo -S apt-get install tig -y
$passw | sudo -S apt-get install etckeeper -y
#configurar la zona horaria con time ctl
$passw | sudo -S timedatectl list-timezones 
$passw | sudo -S timedatectl set-timezone  $timezone
$passw | sudo -S apt-get install ntpdate
$passw | sudo -S ntpdate-debian

$pass | sudo -S etckeeper init
$pass | sudo -S etckeeper commit -m "Initial checkin"


#asignacion de contrasenia 
echo -e  "$passwd\n$repeatwd\n$repeatwd" | passwd
passw= $(echo -e "$repeatwd\n") 
#configuracion de la wlan 
$passw | sudo -S apt install wireless-tools -y
$passw | sudo -S apt install wpasupplicant -y
$passw | sudo -S nmcli dev wifi connect $ssid password $wlanpasswd

#configuracion de ssh 
$passw | sudo -S cp -r packages/sshd_config /etc/ssh/
$passw | sudo -S /etc/init.d/ssh restart

#configuracion de fail2ban 
$passw | sudo -S apt-get install fail2ban -y
$passw | sudo -S cp -r /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
$passw | sudo -S cp -r packages/jail.local /etc/fail2ban/
$passw | sudo -S /etc/init.d/ssh restart

$pass | sudo -S etckeeper commit "Basic Security Completed"

#Configuracion de entorno de desarrollo 
git config --global user.mail $email
git config --global user.name $usergithub

#generacion de llaves publicas 
echo "\n" | sh-keygen -t rsa -b 4096 -C $email -P $passwd_sshkey
#-C asignacion de correo electronico 
#-P asignacion de contrasenia 

$passw | sudo -S etckeeper commit "Git Github/Gitlab basic enviroment completed"

#configuracion de nvm y npm final de comanderia 
$passw | sudo -S apt-get install -y curl build-essential libssl-dev git
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
$passw | su - odroid
nvm ls-remote 
nvm install v10.15.3
npm -v && node -v 

$passw | sudo -S etckeeper commit "nvm with node and npm dependencias installed"

#configurating docker instalation 
$passw | sudo -S apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

$passw | sudo -S apt-get install docker-ce docker-ce-cli containerd.io
$passw | sudo -S groupadd docker
$passw | usermod -aG docker $USER
$passw | sudo -S etckeeper commit "Docker installation was succesfull"

#odroid shifter shell instalation 
$passw | sudo -S apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
git clone https://github.com/hardkernel/wiringPi
cd wiringPi/
./build 

$passw | sudo -S etckeeper commit "WiringPI and Shifter Shield configuration was success"
#modificacion de ohmyzsh 
$passw | sudo -S apt-get install ccze -y 
#dmesg | ccze -A  example to using  log colors with  dmesg 



echo "script terminado!"
echo "passwd user :$repeatwd  passwd_sshkey: $passparse wlanpasswd:$wlanpasswd"  
echo "timezone: $timezone email: $email routerssid: $ssid" 