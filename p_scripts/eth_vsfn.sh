#!/bin/bash 

Mbps_MB_s(){
mbps=$1
kbps_bts=$(echo "scale=2;($mbps*1000)*1000"|bc)
tobyte=$(echo "scale=2; ($kbps_bts/8)"|bc)
KB_MB_s=$(echo "scale=2; ($tobyte/1024)/1024"|bc)
echo $KB_MB_s  #es como return de javascript 
}

Mbps=0
read -p "ingrese su velocidad de Mbps:" Mbps
echo "su velocidad es de:~"$(Mbps_MB_s $Mbps)"MB/s"
varx=$(Mbps_MB_s $Mbps)
echo "data de la variable: $varx"
