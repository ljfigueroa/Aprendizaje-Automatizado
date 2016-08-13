#!/bin/bash
#!/usr/bin/Rscript


data="2 4 8 16 32"

rm data.csv 

for d in $data; do
	rm toCalc
	for i in `seq 1 21`; do
		# Creo el .net y copio los archivos base
		filecopy="ejA-$d"
		filename="$filecopy-$i"
		cp "$filecopy.data" "$filename.data"
		cp "$filecopy.test" "$filename.test"
		echo $d > N1
		cat N1 "ej.net" > "$filename.net"
		# Ejecuto bp
		rm 1.wts 
		../../bp $filename > $filename
		# Guardo el error a promediar 
		grep "%" $filename > TMP1
		sed 's/Test discreto://g ; s/%//g' TMP1 > TM
		cat TM >> toCalc
		#RECUERDO EL ERROR
		tm=`cat TM`
		newfile=$filecopy-$tm
		mv $filename  $newfile
		mv $filename.mse  $newfile.mse
		mv $filename.net $newfile.net
		mv $filename.predic $newfile.predic
		rm "$filename.data"
		rm "$filename.test"
	done
	cat toCalc | xargs echo
	Rscript calcular.r > TMP1
	awk '{print $2}' TMP1 > TMP2 
	#Guardo los resultados
       	echo "$d" > TMP3 
	cat TMP3 TMP2 | paste -sd "," >> data.csv
done
rm TMP* 

