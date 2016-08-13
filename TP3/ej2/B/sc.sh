#!/bin/bash
dData="2 4 8 16 32"
for i in $dData; do
	#Generar test (uno por cada C)
	echo "10000 $i 0.78" > toGenC
	sleep 1
	../../ejB < toGenC
	mv ejB.data ejB.tes
	echo "250 $i 0.78" > toGenerate
	# Configuro parametros
	N_IN=$i      # CANTIDAD DE ENTRADAS
	N_Class=2    # CANTIDAD DE CLASES
	PTOT=250     # cantidad TOTAL de patrones en el archivo .data
	PR=250       # cantidad de patrones de ENTRENAMIENTO
	PTEST=10000  # cantidad de patrones de test (archivo .test)
	SEED=0       # semilla para el rand()
	CONTROL=0    # verbosity
	for j in `seq 1 20`; do
		sleep 1
		../../ejB < toGenerate
		filename="ejB-$i-$j"
		rm ejB.names
		mv ejB.data  "$filename.data"
		cp ejB.tes   "$filename.test"
		# Gernero el .nb
		echo $N_IN    >> "$filename.nb"
		echo $N_Class >> "$filename.nb"
		echo $PTOT    >> "$filename.nb"
		echo $PR      >> "$filename.nb"
		echo $PTEST   >> "$filename.nb"
		echo $SEED    >> "$filename.nb"
		echo $CONTROL >> "$filename.nb"
		../../nb  $filename > $filename
		cat $filename | grep Test | sed 's/Test://g' | sed 's/%//g' >> toProm
		#cat $filename | grep '<<' | awk -F "[()]" '{gsub(/(%| )/,""); print $2}'| paste -d "," - - > BP
		#cat $filename | grep '<<' | awk -F "[()]" '{gsub(/(%| )/,""); print $4}'| paste -d "," - - > AP
		#cat BP AP | paste -sd "," >> toProm
	done
done
python prom.py
python curva.py
rm toProm toGenC toGenerate ejB.tes
