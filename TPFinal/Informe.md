# Trabajo Final 2016

#### Implementaciones, librerías y programas usados:

* **libsvm** para el método de _Support Vector Machine_, su implementación se
puede encontrar [aquí][libsvm-git].  
* **scikit-learn** librería de python requerida para la función [StratifiedKFold][kfold] usada en [sets.py](dir) para dividir el conjunto de entrenamiento en 10 subconjuntos, respetando la proporción original de puntos de cada clase.
* **Rscript** programa de la suit de R.
* **bash**

#### Forma de uso:
* _Ejercicio 1_: La tabla pedida se llama _tabla.csv_ y se la genera ejecutando
 `ej1.sh`
* _Ejercicio 2_: Para realizar los test se requiere _tabla.csv_ generada en el
 _ejercicio 1_, ejecutar `ej2.sh` el output contiene los resultados de los _t-test_.


Ejercicio 1
===========

Contando con los métodos _Naive-Bayes_ (con gaussianas) y Arboles de decisión (_C4.5_) de previos TPs y _SVM_ con un kernel lineal ya está dado, solo me faltaba determinar que kernel no lineal utilizar para el dataset dado.

#### Eligiendo el kernel no lineal

Opté por usar el kernel _Radial Basis Function_ (**RBF**) porque la no linealidad de este kernel mapea las muestras a una dimensión más alta (a diferencia del kernel lineal), de esta forma es mejor para casos cuando la relación entre clases y atributos es no lineal.

Otras ventajas es que el kernel RBF tiene menos dificultades numéricas en contraste con kernel polinomial donde sus valores pueden ir a infinitos o cero si el grado es muy grande, otra ventaja sobre el kernel polinomial es que tiene menos parámetros que optimizar lo que se traduce un un modelo menos complejo y tedioso a la hora de optimizar los parámetros.

El kernel **RBF** tiene como desventaja que en situaciones donde el número de
atributos es muy grande no es conveniente, produciendo resultados parecidos a los de un kernel lineal con un costo en recursos mucho más alto.

#### Particiones del dataset, formato y escalado

En el script [genSets.sh][genSets] para generar las diez particiones del dataset se utiliza el código [sets.py][setspy], tiene el mismo formato que ejecutar `split -d -a 1 -n l/10 cmc.data`, es decir, genera diez conjuntos con un tamaño aproximado de 96 muestras cada uno, pero a diferencia de split genera conjuntos con la misma proporción del clases que _cmc.data_, necesaria para que al realizar la _cross-validation_ tanto el conjunto de train como el de test sean representativos de la muestra en _cmc.data_

Luego de generar los diez conjuntos, se los agrupan en los que después van a ser los respectivos train y test de los algoritmos.

La linea `awk -F, '{printf("%d ",$NF);for(i=1;i<NF;i++){printf "%d:%f ",i,$i}; printf "\n"}'` formatea los datos para que sean compatibles con la implementación  de _libsvm_, luego se los escala al intervalo [0,1] tomando como precaución de guardar los parámetros de escalado para usar los mismos en el test.

Por ultimo se genera una comprobación de que los datos a procesar por las funciones de  _libsvm_ tienen el formato correcto utilizando el script [checkdata.py][checkdatapy] provisto por _libsvm_.

#### Optimizando los parámetros
La optimización de los parámetros de los métodos se realiza en sus respectivos scripts. Veamos el script de **RBF** ([aquí][rbfsc]) que es el mas complejo:

Recordar que **RBF** tiene dos parámetros _G_ y _C_ libres, para facilitar mi trabajo a la hora de optimizarlos los elijo entre los siguientes conjuntos
* C en {2^−5 , 2^−3 ,..., 2^15}
* G en {2^−15, 2^−13,..., 2^3}

A pesar de no usar un método exautivo para la búsqueda de los parámetros óptimos, la perdida de precisión se transforma en una ganancia en velocidad a la hora de la búsqueda.

Tras ejecutar el tercer for anidado con los parámetros correspondientes tomo la mediana de las diez medidas generadas tras entrenar y testar los conjuntos y determino que esa es la precisión que representa los parámetros fijados, luego comparo con la mejor medición tomada hasta el momento y no solo guardo la mejor medición sino también los valores de la precisión sobre los conjuntos.


Al terminar el script guarda en _Results.rbf-cross-validation_ los parámetros optimizados, la precisión sobre los conjuntos y la mediana de los mismos que se utilizo para determinar que parámetros eran óptimos.

#### Tabla de precisión de los métodos

Utilizando el script [genTabla.sh][genTabla] para combinar los resultados de los métodos, se generó la siguiente tabla

|                 | C4.5             | Naive-Bayes      | SVM - K. Lineal  | SVM - Kernel RBF |
|-----------------|------------------|------------------|------------------|------------------|
| S1              | 76.3             | 60.824742        | 74.2268          | 74.2268          |
| S2              | 77.3             | 67.010309        | 75.2577          | 75.2577          |
| S3              | 73.2             | 62.886598        | 73.1959          | 73.1959          |
| S4              | 74.0             | 65.625000        | 71.875           | 70.8333          |
| S5              | 76.0             | 66.666667        | 76.0417          | 75               |
| S6              | 70.8             | 66.666667        | 71.875           | 73.9583          |
| S7              | 71.9             | 63.541667        | 69.7917          | 73.9583          |
| S8              | 68.8             | 66.666667        | 73.9583          | 70.8333          |
| S9              | 71.9             | 73.958333        | 69.7917          | 67.7083          |
| S10             | 75.8             | 74.736842        | 82.1053          | 80               |
| Promedio        | 73.6             | 66.8583492       | 73.81191         | 73.49719         |
| Desvío estándar | 2.76003220593126 | 4.43864958494825 | 3.59386884551701 | 3.27272550074433 |





Ejercicio 2
===========

Observando la tabla del _ejercicio 1_ los métodos que vamos a analizar son:
* Mejor resultado: SVM - Kernel Lineal
* Segundo mejor resultado: C4.5 - Arboles de decisión
* Peor resultado: Naive-Bayes con gaussianas

El output de ejecutar el script `ej2.sh` es:

>  Mejor vs Peor:  6.953561  +-  3.269524  
>  Mejor vs Segundo Mejor:  0.21191  +-  2.24675

El primer valor, llamado _delta_, es el promedio de las diferencias de precisión tras aplicar los dos métodos de aprendizaje sobre los mismos conjuntos, mientras menor sea el _delta_ menor sera la diferencia entre los métodos de aprendizaje. En este caso se ve como entre el Mejor y el Segundo Mejor la diferencia es ínfima, mientras que entre el Mejor y Peor es casi del 7% haciendo que la elección del algoritmo tenga un impacto significativo sobre la clasificación.

¿Pero cuan _confiable_ es ésta estimación?

Esta comparación se realizo sobre _cmc.data_, un subconjunto de la distribución original de los datos, por lo tanto este procedimiento no es representativo de la diferencia real entre los algoritmos porque no se evaluaron sobre todas las instancias que pueden ocurrir.

Dicho lo anterior, ahí es donde entra el segundo valor. El mismo esta compuesto de la multiplicación de dos términos:
* Un porcentaje de confidencia, siendo en esta ocasión del 95% que garantiza una  probabilidad del 95%  que que el _verdadero error_ ocurra en el intervalo resultante.
* Una estimación del desvío estándar de la distribución que gobierna a _delta_.


##### Conclusión
Al momento de elegir un método para clasificar datos sobre la misma distribución que los de _cmc.data_, si los recursos y el tiempo de computo no fueran un problema, elegiría _SVM_ con un kernel lineal para clasificar los datos, pero de no poseer tales recursos optaría por Arboles de decisión, ya que es menos costoso y mas rápido de ejecutar pues no hay que optimizar valor alguno.

Además por los resultados del _ejercicio 2_ tendría garantizado que existe una probabilidad del 95% que la diferencia entre ambos algoritmos este un intervalo muy pequeño.

[libsvm-git]: https://github.com/cjlin1/libsvm
[kfold]: http://scikit-learn.org/stable/modules/generated/sklearn.cross_validation.StratifiedKFold.html#sklearn.cross_validation.StratifiedKFold
[setspy]: sets.py
[checkdatapy]: a
[genSets]: a
[rbfsc]: a
[genTabla]: a
