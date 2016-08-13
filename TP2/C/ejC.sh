#!/bin/bash
#!/usr/bin/Rscript


data="190 150 100"

rm data.csv

for d in $data; do
	rm toCalc
	for i in `seq 1 21`; do
		# Creo el .net y copio los archivos base
		filecopy="ikeda-$d"
		filename="$filecopy-$i"
		cp "ikeda.data" "$filename.data"
		cp "ikeda.test" "$filename.test"
		#cp "ikeda.net"  "$filename.net"
		#netfile="$filename.net"
		# Completo el PR
		PR=$d
		echo $PR > pr
		# Borro el netfile que puede haber quedado de otra ejecución
		cat headfile pr tailfile > "$filename.net"
		#$rm $netfile
		# Genero nuevo netfile
		# Ejecuto bp
		rm 1.wts
		../bp $filename > $filename
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

