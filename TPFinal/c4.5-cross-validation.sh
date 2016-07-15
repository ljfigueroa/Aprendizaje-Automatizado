#!/bin/bash

for i in `seq 0 9`; do
	namefile="cmc-$i.original"
	# Generate .names
	cp cmc.names $namefile.names
	error_test=`./c4.5 -f $namefile -u | grep '<<' | awk -F "[()]" '{gsub(/(%| )/,""); print $4}' | tail -n 1`
	echo "scale=8; 100 - $error_test" | bc >> toCalc
done
result=`Rscript calcular.r | awk -F' ' '{print $2}'`
echo "Promedio= $result"
echo "Promedio= $result" > "Results.c4.5-cross-validation"
cat toCalc >> "Results.c4.5-cross-validation"
rm toCalc

#Clean
#sh clean.sh
