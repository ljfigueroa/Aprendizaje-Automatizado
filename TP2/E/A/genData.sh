#!/bin/bash

dData="2 4 8 16 32"


for i in $dData; do
	#Generar test (uno por cada C)
	echo "10000 $i 0.78" > toGenerate
	sleep 1
	./ejA < toGenerate
	./ejB < toGenerate

	mv ejA.data  "ejA.test"
	mv ejB.data  "ejB.test"

	rm ejA.names  ejB.names

	echo "250 $i 0.78" > toGenerate
	sleep 1
	./ejA < toGenerate
	./ejB < toGenerate

	filename="ejA-$i"
	rm ejA.names
	mv ejA.data     "$filename.data"
	cp "ejA.test"   "$filename.test"
	filename="ejB-$i"
	rm ejB.names 
	mv ejB.data     "$filename.data"
	cp "ejB.test"   "$filename.test"	

done
rm toGenerate
