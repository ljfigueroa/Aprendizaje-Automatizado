#!/bin/bash

rm toCalc
file=ejC

# Genero el conjunto de test
echo 2000 > toGenerate
../ejC < toGenerate
mv ejC.data "ejC.test"

# Datos a generar
echo 1600 > toGenerate

for j in `seq 1 20`; do
	sleep 1
	../ejC < toGenerate
	filename="$file-$j"
	#Genero el .data y .test correspondiente
	cp "$file.data" "$filename.data"
	cp "$file.test" "$filename.test"
	cp "$file.nb"   "$filename.nb"
	#Computo knn
	./knn  $filename > $filename
	cat $filename | grep Test | sed 's/Test://g' | sed 's/%//g' >> toCalc
done
Rscript "calcular.r" | awk '{print $2}'  > ERROR
