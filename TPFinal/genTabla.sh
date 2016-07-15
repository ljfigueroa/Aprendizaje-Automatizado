#!/bin/bash

tail -n +2 "Results.c4.5-cross-validation"    > c
tail -n +2 "Results.bayes-cross-validation"   > b
tail -n +4 "Results.rbf-cross-validation"     > r
tail -n +3 "Results.linear-cross-validation"  > l
paste -d"," c b l r > data.csv

Rscript tabla.r > md
cp data.csv tabla.csv
cat md | sed 's/^[^\"]*\"//g ; s/\"//g' | awk '{print $1}' | paste -sd"," >> tabla.csv
cat md | sed 's/^[^\"]*\"//g ; s/\"//g' | awk '{print $2}' | paste -sd"," >> tabla.csv

rm c b l r md data.csv
