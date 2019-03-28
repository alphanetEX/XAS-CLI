#!/bin/bash 
passwd=$(echo -e "odroid\n")
repeatwd=""
passparse=""
wlanpasswd=""
timezone=""
ssid=""
email=""

validate(){
  if($1 == $2 ); then
     echo "true"
  else  
     echo "false"
  fi
}


echo "test"
read -s -p "ingrese su contrasenia del nueva para el usuario $(whoami): " repeatwd
read -s -p "ingrese contrasenia de la keygen ssh :" passparse
read -p "ingrese timezone de su sevidor: " timezone
read -p "ingrese SSID de Wlan0" ssid
read -s -p "ingrese su contrasenia de la wlan del router: " wlanpasswd
read -p "ingrese su mail asociado a github/gitlab: " email 

echo "passwd user :$repeatwd  passwd passparse: $pasparse wlanpasswd:$wlanpasswd"  
echo "timezone: $timezone email: $email routerssid: $ssid"

 
  if [[ $val == "true" ]]; then
    else
    echo "las contrasenias no coinciden repita el proceso"
    read -s -p "ingrese su contrasenia del nueva para el usuario $(whoami): " repeatwd
    read -s -p "repita nuevamente la contrasenia para $(whoami): " repeatwd2

    fi 