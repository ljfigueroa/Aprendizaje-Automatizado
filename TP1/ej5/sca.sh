#!/bin/bash
rm toProm toPromNodes
nData="100 200 300 500 1000 5000"
for i in $nData; do
	echo "$i 2 0.75" > toGenerate
	for j in `seq 1 20`; do
		sleep 1
		./ejA < toGenerate
		filename="ejA$i-$j"
		mv ejA.names "$filename.names"
		mv ejA.data  "$filename.data"
		cp ejA.tes   "$filename.test"
		../c4.5 -f $filename -u > $filename
		cat $filename | grep '<<' | awk -F "[()]" '{gsub(/(%| )/,""); print $2}'| paste -d "," - - > BP
		cat $filename | grep '<<' | awk -F "[()]" '{gsub(/(%| )/,""); print $4}'| paste -d "," - - > AP
		cat BP AP | paste -sd "," >> toProm
		cat $filename | grep '<<' | awk -F "[()]" '{print $1}' | awk '{print $1}' | paste -d "," - - > BP
		cat $filename | grep '<<' | awk -F "[()]" '{print $3}' | awk '{print $1}' | paste -d "," - - > AP
		cat BP AP | paste -sd "," >> toPromNodes
	done
done
python prom.py
