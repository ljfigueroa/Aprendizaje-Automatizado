#!/bin/bash

echo "Generando los conjuntos de cross-validation ..."
sh genSets.sh
echo "Ejecuando linear-cross-validation ..."
sh linear-cross-validation.sh
echo "Ejecuando rbf-cross-validation ..."
sh rbf-cross-validation.sh
echo "Ejecuando bayes-cross-validation ..."
sh bayes-cross-validation.sh
echo "Ejecuando c4.5-cross-validation ..."
sh c4.5-cross-validation.sh
echo "Creando tabla ..."
sh genTabla.sh
echo "Limpiando ..."
sh clean.sh
