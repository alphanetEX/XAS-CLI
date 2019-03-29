#!/bin/bash
#Developer:alphanetEX 
#Basic Configuration Eviroment of Ubunutu for AWSEC2 
passw= echo -e "odroid\n" 
$passw | sudo -S apt-get update
$passw | sudo -S apt-get upgrade -y -f
$passw | sudo -S apt-get install vim -y
$passw | sudo -S apt-get install trickle #network velocity limit 
$passw | sudo -S apt-get install tig -y
$passw | sudo -S apt-get install etckeeper -y
#configure timezone to asignate correct time in your server and evit change modification of time
$passw | sudo -S timedatectl list-timezones
$passw | sudo -S timedatectl set-timezone "America/Argentina/Buenos_Aires"
$passw | sudo -S apt-get install ntpdate
$passw | sudo -S ntpdate-debian

$pass | sudo -S etckeeper init
$pass | sudo -S etckeeper commit -m "Initial checkin"

#asing new passwd to sudoer user 
echo -e  "odroid\nnewpass\nrepeatpass" | passwd
passw= echo -e "newpass\n"

#wlan configuration  
$passw | sudo -S apt install wireless-tools -y
$passw | sudo -S apt install wpasupplicant -y
$passw | sudo -S nmcli dev wifi connect "SSID-ROUTER" password "PASS-WLAN"

#ssh configuration 
$passw | sudo -S cp -r packages/sshd_config /etc/ssh/
$passw | sudo -S /etc/init.d/ssh restart

#fail2ban configuration  
$passw | sudo -S apt-get install fail2ban -y
$passw | sudo -S cp -r /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
$passw | sudo -S cp -r packages/jail.local /etc/fail2ban/
$passw | sudo -S /etc/init.d/ssh restart

$pass | sudo -S etckeeper commit "Basic Security Completed"


#Github/Gitlab developer configuration 
git config --global user.mail "EMAIL"
git config --global user.name "USER"

#generating ssh keys  
echo "\n" | sh-keygen -t rsa -b 4096 -C "email" -P "passparse"
#-C email asignation
#-P password asignation   

$passw | sudo -S etckeeper commit "Git Github/Gitlab basic enviroment completed"

#configuracion de nvm y npm final de comanderia 
$passw | sudo -S apt-get install -y curl build-essential libssl-dev git
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
$passw | su - odroid #check and comprobate this section 
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
$passw | sudo -S apt-get install ccze -A
#dmesg | ccze -A 


echo "script was ended!"

WORKING STAGE