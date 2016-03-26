#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# converter imagens em texto
for arq in Img*.bmp
do 
  if [ $arq -nt "${arq::-4}".tmp ]
  then
    echo "${arq::-4}"
    od -j 1078 -w296 -A n -v -t x1 $arq > "${arq::-4}".tmp
  fi
done


# inverter linhas
for arq in *.tmp
do 
  cat $arq | tac > "${arq::-4}".txt
  rm $arq
done

# converter em matrizes de vhdl
for arq in *.txt
do
  if [ $arq -nt "${arq::-4}".vhd ]
  then
    saida="${arq::-4}".vhd
    echo $saida
    echo -n "(" >> $saida
    cat $arq | while IFS='' read -r line || [[ -n "$line" ]]; do
      echo -n "(" >> $saida
      echo $line | while IFS= read -r -N 3 i; do
        # if [[ "$i" == *$'\n' ]]; then
        #   echo  "(" >> $saida
        #   echo  -n "X\"${i: -2}\")," >> $saida
        # else
          echo -n "X\"${i: -2}\"," >> $saida
        # fi
      done
      sed -i '$ s/.$//' $saida
      echo ")," >> $saida
    done
    sed -i '$ s/.$//' $saida
    sed -i '$ s/.$//' $saida
    echo -n "));" >> $saida
  fi
  rm $arq
done

IFS=$SAVEIFS

