#!/bin/bash

for i in `seq 0 9`; do
	namefile="cmc-$i.original"
	# Generate .nb
	head -n 2 cmc.nb > $namefile.nb
	PTOT=`cat $namefile.data | wc -l`
	PR=$PTOT
	PTEST=`cat $namefile.test | wc -l`
	echo $PTOT  >> $namefile.nb
	echo $PR    >> $namefile.nb
	echo $PTEST >> $namefile.nb
	tail -n +3 cmc.nb >>  $namefile.nb
	error_test=`./nb $namefile | grep Test | sed  's/^[^:]*://g ; s/\%//g'`
	echo "scale=8; 100 - $error_test" | bc >> toCalc
done
result=`Rscript calcular.r | awk -F' ' '{print $2}'`
echo "Promedio= $result"
echo "Promedio= $result" > "Results.bayes-cross-validation"
cat toCalc >> "Results.bayes-cross-validation"
rm toCalc

#Clean
#sh clean.sh
