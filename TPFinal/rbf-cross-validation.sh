#!/bin/bash

validation=10

csearch=`seq -5 15`
gsearch=`seq -15 3`

#Search of C and G
best_c=-5
best_g=-15
best_a=0
for c in $csearch; do
	for g in $gsearch; do
		for i in `seq 0 9`; do
			namefile="cmc-$i"
			C=`echo "scale=16;2^$c" | bc`
			G=`echo "scale=16;2^$g" | bc`
			#echo $C $G
			./svm-train -q -c $C -g $G "$namefile.data"
			./svm-predict "$namefile.test" "$namefile.data.model" "$namefile.predic" > accuracy
			awk -F% '{print $1}' accuracy | awk -F'= ' '{print $2}' >> toCalc
		done
		new_accuracy=`Rscript calcular.r | awk -F' ' '{print $2}'`
		C=`echo "scale=16;2^$best_c" | bc`
		G=`echo "scale=16;2^$best_g" | bc`
		echo "new_accuracy= $new_accuracy, c= $c & g= $g \t BEST-> c= $C g= $G ac= $best_a"
		if [ $(echo "$best_a < $new_accuracy" | bc) -eq 1 ];
		then
			best_c=$c
			best_g=$g
			best_a=$new_accuracy
			# Save the output of the best data
			cp toCalc output
		fi
		rm toCalc accuracy
	done
done
C=`echo "scale=16;2^$best_c" | bc`
G=`echo "scale=16;2^$best_g" | bc`
echo "Best c= $C\nBest g= $G\nBest accuracy $best_a" > "Results.rbf-cross-validation"
cat output >> "Results.rbf-cross-validation"
rm output

#Clean
#sh clean.sh
