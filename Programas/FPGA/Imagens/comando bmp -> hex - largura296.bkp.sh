#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for arq in *.bmp
do 
  if [ $arq -nt "${arq::-4}".vhd ]
  then
    echo "${arq::-4}"
    od -j 1078 -w296 -A n -v -t x1 $arq > "${arq::-4}".vhd
    
  fi
done
IFS=$SAVEIFS

