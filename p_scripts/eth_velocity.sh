#!/bin/bash

publicvar=0
convert_dec(){
    publicvar=$(echo "scale=2; $1"| bc)
    echo "$publicvar" #el echo es el return de la funcion 
}


#sintaxis del ejercicio de la velocidad de internet  
mb=0
read -p "introdusca la cantidad de Mb:" mb
tokb_bit=$(echo "scal0e=2; ($mb*1000)*1000"|bc)
tobytes=$((tokb_bit/8))
toKB_MB=$(echo "scale=2; ($tobytes/1024)/1024"|bc)
echo "la cantidad de Mb/s son: ~$toKB_MB"




#sintaxis del ejercicio utlizando una funcion no sintetizado 
nKbyte_Mbytes=$(echo "scale=2;($tobytes/1024)/1024"| bc)
result=$(convert_dec $nKbyte_Mbytes) 
echo "lo que tiene la variable result $result"



#pruebas 
decimal=$((12*5))
printf "date in %0.2f\n" $decimal


#ejercicio de velocidad de internet sintetizado 
con_to_MB(){
nKbyte_Mbytes=$(echo "scale=2;($1/1024)/1024"| bc)
echo $nKbyte_Mbytes
}


result=$(con_to_MB $tobytes)
echo "la velocidad de su internet es: "$result
