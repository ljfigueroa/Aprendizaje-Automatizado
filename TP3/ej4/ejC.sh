#!/bin/bash

rm toProm
bins="5 10 15 20 25 30"
file=ejC
for i in $bins; do
	# Configuro parametros
	BINS=$i   # cantidad de bins en el histograma
	for j in `seq 1 20`; do
		sleep 1
		filename="$file-$i-$j"
		#Genero .nb
		cat $file.nb > $filename.nb
		echo $BINS >> $filename.nb
		#Genero el .data y .test correspondiente
		cp "$file.data" "$filename.data"
		cp "$file.test" "$filename.test"
		#Computo bayes
		./nb  $filename > $filename
		cat $filename | grep Entrenamiento | sed 's/Entrenamiento://g' | sed 's/%//g' > E
		cat $filename | grep Validacion | sed 's/Validacion://g' | sed 's/%//g' > V
		cat $filename | grep Test | sed 's/Test://g' | sed 's/%//g' > T
		cat E V T | paste -sd"," >> toProm
	done
done
python prom.py
#python curva.py
