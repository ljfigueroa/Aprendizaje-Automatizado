#!/bin/bash
rm toCurva
cData="0.5 1.0 1.5 2.0 2.5"
for i in $cData; do
	for j in `seq 1 20`; do
		filename="ejB$i-$j"
		grep class $filename > tmp
		error1=`awk '{print $1}' tmp | tail -n1`
		error2=`awk '{print $2}' tmp | tail -n2 | head -n1`
		errortotal=`echo "$error1 + $error2" | bc`
		echo $errortotal >> toCurva
	done
done
