#!/bin/bash

validate(){
    echo "valor: $1  valor2: $2"
  if [[ $1 == $2 ]]; then
     echo "true"
  else  
     echo "false"
  fi
}

darpa="ether"
darpa1="ether"
echo "$(validate $darpa $darpa1)"

val= $(validate $repeatwd $repeatwd2)