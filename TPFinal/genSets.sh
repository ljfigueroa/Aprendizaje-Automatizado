#!/bin/bash


original=cmc.original.data               # C4.5 and Naive-Bayed formated data.
shuffled_data=cmc.original.shuf.data
validation=10

cp cmc.data $original

# Shuffle data and split it in $validation parts
#shuf $original > $shuffled_data
#split -d -a 1 -n l/$validation $shuffled_data

python sets.py > t

#Generate cross-validation sets
for i in `seq 0 9`; do
	original="cmc-$i.original" # C4.5 and Naive-Bayes
	formated="cmc-$i"	   # SVM
	for j in `seq 0 9`; do
		if [ "$i" != "$j" ];
		then
			cat x$j >> "$original.data"
		fi
	done
	cat x$i > "$original.test"
	# Format and scale
	awk -F, '{printf("%d ",$NF);for(i=1;i<NF;i++){printf "%d:%f ",i,$i}; printf "\n"}' $original.data > "$formated.data.nonscaled"
	awk -F, '{printf("%d ",$NF);for(i=1;i<NF;i++){printf "%d:%f ",i,$i}; printf "\n"}' "$original.test" > "$formated.test.nonscaled"
	./svm-scale -l 0 -u 1 -s scaling_parameters "$formated.data.nonscaled" > "$formated.data"
	./svm-scale -r scaling_parameters "$formated.test.nonscaled" > "$formated.test"
	python checkdata.py "$formated.data"
	python checkdata.py "$formated.test"
done
