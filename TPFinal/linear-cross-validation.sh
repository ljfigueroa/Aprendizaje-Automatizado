#!/bin/bash

csearch=`seq -5 15`

#Search of C and G
best_c=-5
best_a=0
for c in $csearch; do
	for i in `seq 0 9`; do
		namefile="cmc-$i"
		C=`echo "scale=16;2^$c" | bc`
		#echo $C $G
		./svm-train -q -c $C -s 0 "$namefile.data"
		./svm-predict "$namefile.test" "$namefile.data.model" "$namefile.predic" > accuracy
		awk -F% '{print $1}' accuracy | awk -F'= ' '{print $2}' >> toCalc
	done
	new_accuracy=`Rscript calcular.r | awk -F' ' '{print $2}'`
	C=`echo "scale=16;2^$best_c" | bc`
	echo "new_accuracy= $new_accuracy  & c= $c \t BEST-> c= $C & ac= $best_a"
	if [ $(echo "$best_a < $new_accuracy" | bc) -eq 1 ];
	then
		best_c=$c
		best_a=$new_accuracy
		# Save the output of the best data
		cp toCalc output
	fi
	rm toCalc accuracy
done
C=`echo "scale=16;2^$best_c" | bc`
echo "Best c= $C\nBest accuracy $best_a" > "Results.linear-cross-validation"
cat output >> "Results.linear-cross-validation"
rm output

#Clean
#sh clean.sh
