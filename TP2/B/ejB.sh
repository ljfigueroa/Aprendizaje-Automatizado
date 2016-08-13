#!/bin/bash
#!/usr/bin/Rscript

# los parametros corresponden a=0
N1=2         # NEURONAS EN CAPA DE ENTRADA
N2=0         # NEURONAS EN CAPA INTERMEDIA
N3=1         # NEURONAS EN CAPA DE SALIDA
PTOT=2000    # cantidad TOTAL de patrones en el archivo .data
PR=1600      # cantidad de patrones de ENTRENAMIENTO
PTEST=2000   # cantidad de patrones de test (archivo .test)
ITER=40000   # Total de Iteraciones
ETA=0.01     # learning rate
u=0.5        # Momentum
NERROR=400   # graba error cada NERROR iteraciones
WTS=0        # numero de archivo de sinapsis inicial
SEED=0       # semilla para el rand()
CONTROL=0    # verbosity

# Comentarios:
# WTS=0 implica empezar la red con valores al azar
# cantidad de patrones de validacion: PTOT - PR
# SEED: -1: No mezclar los patrones: usar los primeros PR para entrenar y
#           el resto para validar.
#        0: Seleccionar semilla con el reloj, y mezclar los patrones.
#       >0: Usa el numero como semilla, y mezcla los patrones.
# verbosity: 0:resumen, 1:0 + pesos, 2:1 + datos


capa_intermedia="2 5 10 20 40"

rm data.csv

for ci in $capa_intermedia; do
	rm toCalc
	for i in `seq 1 21`; do
		# Creo el .net y copio los archivos base
		filecopy="dos_elipses-$ci"
		filename="$filecopy-$i"
		cp "dos_elipses.data" "$filename.data"
		cp "dos_elipses.test" "$filename.test"
		netfile="$filename.net"
		# Completo la cantidad de capa intermedia
		N2=$ci
		# Borro el netfile que puede haber quedado de otra ejecución
		#rm $netfile
		# Genero nuevo netfile
		echo $N1      >> "$netfile"  # NEURONAS EN CAPA DE ENTRADA
		echo $N2      >> "$netfile"  # NEURONAS EN CAPA INTERMEDIA
		echo $N3      >> "$netfile"  # NEURONAS EN CAPA DE SALIDA
		echo $PTOT    >> "$netfile"  # cantidad TOTAL de patrones en el archivo .data
		echo $PR      >> "$netfile"  # cantidad de patrones de ENTRENAMIENTO
		echo $PTEST   >> "$netfile"  # cantidad de patrones de test (archivo .test)
		echo $ITER    >> "$netfile"  # Total de Iteraciones
		echo $ETA     >> "$netfile"  # learning rate
		echo $u       >> "$netfile"  # Momentum
		echo $NERROR  >> "$netfile"  # graba error cada NERROR iteraciones
		echo $WTS     >> "$netfile"  # numero de archivo de sinapsis inicial
		SEED=0
		echo $SEED    >> "$netfile"  # semilla para el rand()
		echo $CONTROL >> "$netfile"  # verbosity
		# Ejecuto bp
		rm 1.wts
		../bp $filename > $filename
		# Guardo el error a promediar
		grep "%" $filename > TMP1
		sed 's/Test discreto://g ; s/%//g' TMP1 > TM
		cat TM >> toCalc
		#RECUERDO EL MINIMO
		tm=`cat TM`
		newfile=$filecopy-$tm
		mv $filename         $newfile
		mv $filename.mse     $newfile.mse
		mv $filename.net     $newfile.net
		mv $filename.predic  $newfile.predic
		cp $filename.data    $newfile.data
		cp "$filename.test"  "$newfile.test"
	done
	cat toCalc | xargs echo
	Rscript calcular.r > TMP1
	awk '{print $2}' TMP1 > TMP2
	#Guardo los resultados
	echo "$ci" > TMP3
	cat TMP3 TMP2 | paste -sd "," >> data.csv
done
rm TMP*
