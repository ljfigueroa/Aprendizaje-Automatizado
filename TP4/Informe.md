Ejercicio a: Implementación del algoritmo.
==========================================

El método de clasificación de k-primeros-vecinos se implemento
reutilizando la estructura del código base de Naive-Bayes.

El archivo de input tiene el siguiente formato:

    N_IN:        Cantidad de entradas
    N_Class:     Cantidad de clases
    PTOT:        Cantidad TOTAL de patrones en el archivo .data
    PTEST:       Cantidad de patrones de test (archivo .test)
    SEED:        Semilla para el rand()
    CONTROL:     Verbosity
    N_K:         Número de vecinos a visitar:
                 0 -> utilizar un validación para optimizar la
                      cantidad de vecinos a visitar.
                 n -> se visitan n vecinos.

Si N_K es cero se utiliza el 80% de los datos datos del archivo .data
para entrenar, el 20% para validar y se elige entre k entre 1 y 100
que tenga el menor error de validación. Luego se ejecuta el algoritmo
como si se hubiera ingresado en N_K el k elegido por la validación.

Se modificaron algunas variables globales y se agregaron tres
funciones nuevas distancia_euclidiana, cmp y k_nearest. El código
correspondiente a cada una tiene la descripción completa de lo que
hacen.

Ejercicio b: Aplicando knn sobre el dataset de espirales anidadas.
==================================================================

Tras aplicar el algoritmo con k=1 donde k es la cantidad de vecinos a
consultar, interpreto el resultado como espectacular.

Comparando los resultados con una red neuronal entrenada
aproximadamente con los mismos parámetros de entrada (1600 datos de
entrenamiento y 2000 de test) se obtiene una predicción igual o
superior a la red con 40 neuronas en la capa intermedia.

Esto no solo se puede observar en la gráfica, donde el centro de las
espirales de la predicción de knn se asemeja más a la original
(incluida para referencia c-graph.pdf) sino también en el error de
test, donde knn tiene un error del 5.8% mientras que la red neuronal
con la cual comparo tiene 7.85% de error promedio de test (según lo
entregado en el TP2).

Además el resultado logrado se consigue con un algoritmo mucho mas
barato en recursos y tiempo a pesar de que mi implementación no es la
óptima (la implementación dada es O(n^2)) y podría lograrse O(n*lg(n))
o probablemente también O(lg(n)) si se logra paralelizar la búsqueda
de los k-vecinos mas cercanos.


Ejercicio c: Dimensionalidad.
=============================

Resultados de knn:

Diagonal: Error porcentual promedio de test

|Cantidad de inputs | k elegido por validación | k = 1  |
|-------------------|--------------------------|--------|
| 2  | 11.3805               | 13.778 |
| 4  | 11.346                | 15.5035|
| 8  | 10.821                | 16.562 |
| 16 | 12.898                | 21.251 |
| 32 | 12.864                | 24.8715|


Paralelo:		Error porcentual promedio de test

| Cantidad de inputs | k elegido por validación | k = 1 |
|--------------------|--------------------------|-------|
| 2  | 11.286  | 14.042  |
| 4  | 11.1765 | 15.0515 |
| 8  | 11.3905 | 17.0275 |
| 16 | 12.365  | 21.081  |
| 32 | 13.343  | 25.7725 |

Observando las tablas de Paralelo y Diagonal se puede concluir que k=1
no es un buen k dado que para cualquier input en ambos datasets
siempre arroja peores resultados.

Comparando estos resultados con los obtenidos en Arboles de decisión,
redes neuronales y Naive-Bayes aunque difícil de distinguir en la
gráfica se puede observar que el algoritmo knn sobre ambos datasets
arroja mejores resultados que arboles de decisión y redes neuronales
pero no se puede decir lo mismo para los resultados de Naive-Bayes que
para ambos casos parece comportarse como una cota inferior.


El problema de la dimensionalidad afecta al algoritmo, notar cuando
k=1 y aumenta la dimensión el error crece rápidamente, la separación
de los puntos en el espacio hace difícil la clasificación. Mientras
que cuando se optimiza el k a través de un conjunto de validación se
elige claramente una cantidad de vecinos que amortigua
significativamente el error porcentual de test.
