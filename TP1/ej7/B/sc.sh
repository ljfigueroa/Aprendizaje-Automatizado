#!/bin/bash
rm toProm toPromNodes
dData="2 4 8 16 32"
for i in $dData; do
	#Generar test (uno por cada C)
	echo "10000 $i 0.78" > toGenC
	sleep 1
	./ejB < toGenC
	mv ejB.data ejB.tes
	echo "250 $i 0.78" > toGenerate
	for j in `seq 1 20`; do
		sleep 1
		./ejB < toGenerate
		filename="ejB$i-$j"
		mv ejB.names "$filename.names"
		mv ejB.data  "$filename.data"
		cp ejB.tes   "$filename.test"
		../../c4.5 -f $filename -u > $filename
		cat $filename | grep '<<' | awk -F "[()]" '{gsub(/(%| )/,""); print $2}'| paste -d "," - - > BP
		cat $filename | grep '<<' | awk -F "[()]" '{gsub(/(%| )/,""); print $4}'| paste -d "," - - > AP
		cat BP AP | paste -sd "," >> toProm
		cat $filename | grep '<<' | awk -F "[()]" '{print $1}' | awk '{print $1}' | paste -d "," - - > BP
		cat $filename | grep '<<' | awk -F "[()]" '{print $3}' | awk '{print $1}' | paste -d "," - - > AP
		cat BP AP | paste -sd "," >> toPromNodes
	done
done
python prom.py
