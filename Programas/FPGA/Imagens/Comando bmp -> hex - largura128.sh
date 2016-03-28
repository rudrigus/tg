#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
rm *.txt *.tmp *.vhd

# converter imagens em texto
for arq in Img4*.bmp
do 
  if [ $arq -nt "${arq::-4}".tmp ]
  then
    echo "${arq::-4}"
    # od -j 444 -w384 -A n -v -t x1 $arq > "${arq::-4}".tmp
    od -j 54 -w384 -A n -v -t x1 $arq > "${arq::-4}".tmp
  fi
done


# inverter linhas
for arq in *.tmp
do 
  cat $arq | tac > "${arq::-4}".txt
  # cat $arq | tac > "${arq::-4}0".vhd
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
      echo $line | while IFS= read -r -N 9 i; do
          echo -n "X\"${i: -2}\"," >> $saida
          echo -n "${i: -3}" >> "${arq::-4}2".vhd
      done
      sed -i '$ s/.$//' $saida
      echo ")," >> $saida
      echo "," >> "${arq::-4}2".vhd
    done
    sed -i '$ s/.$//' $saida
    sed -i '$ s/.$//' $saida
    echo -n "));" >> $saida
  fi
  # rm $arq
done

IFS=$SAVEIFS

