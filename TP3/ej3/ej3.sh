#!/bin/bash
filename="dos_elipses"
../nb $filename > $filename

filename="ejC"
echo "2000" > t
../ejC < t
mv ejC.data "ejC.test"
echo "1600" > t
../ejC < t
rm ejC.names t

# Configuro parametros
N_IN=2       # CANTIDAD DE ENTRADAS
N_Class=2    # CANTIDAD DE CLASES
PTOT=1600    # cantidad TOTAL de patrones en el archivo .data
PR=1600      # cantidad de patrones de ENTRENAMIENTO
PTEST=2000   # cantidad de patrones de test (archivo .test)
SEED=0       # semilla para el rand()
CONTROL=0    # verbosity

# Gernero el .nb
echo $N_IN    >> "$filename.nb"
echo $N_Class >> "$filename.nb"
echo $PTOT    >> "$filename.nb"
echo $PR      >> "$filename.nb"
echo $PTEST   >> "$filename.nb"
echo $SEED    >> "$filename.nb"
echo $CONTROL >> "$filename.nb"

../nb $filename > $filename
#sh discretizar.sh
Rscript graficar.r
sh clean.sh
