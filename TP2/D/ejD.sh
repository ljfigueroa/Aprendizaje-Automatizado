#!/bin/bash
#!/usr/bin/Rscript


data="0.00000001 0.0000001 0.000001 0.00001 0.0001 0.001 0.01 0.1 1"

rm data.csv

for d in $data; do
	rm toCalc
	for i in `seq 1 21`; do
		# Creo el .net y copio los archivos base
		filecopy="ssp-$d"
		filename="$filecopy-$i"
		cp "ssp.data" "$filename.data"
		cp "ssp.test" "$filename.test"
		#cp "ikeda.net"  "$filename.net"
		#netfile="$filename.net"
		# Completo el PR
		GAMMA=$d
		echo $GAMMA > pr
		# Borro el netfile que puede haber quedado de otra ejecución
		cat headfile pr > "$filename.net"
		#$rm $netfile
		# Genero nuevo netfile
		# Ejecuto bp
		#rm 1.wts
		./bp $filename > $filename
		# Guardo el error a promediar

		#grep "%" $filename > TMP1
		#sed 's/Test discreto://g ; s/%//g' TMP1 > TM
		#cat TM >> toCalc
		cat $filename | grep Test: | tail -n1 | awk -F: '{print $2}' > TM
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

