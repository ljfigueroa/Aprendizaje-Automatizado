# Resoluciones del TP2


Ejercicio A: Mínimos locales
============================

Se entrenó la red con el dataset de dos-elipses variando el momentum y
learning-rate entre los valores 0, 0.5, 0.9 para el momentum y 0.1,
0.01, 0.001 respectivamente. Cada configuración de la red se ejecuto
21 veces y de entre los errores de test discretos se eligió la
mediana, la cual la considero la mas representativa de las ejecuciones
con esa configuración, quedando conformada la siguiente tabla:
(también encontrada en A/data.csv)

| Learning-rate |   Momentum      |   Error discreto |  
|---------------|-----------------|------------------|
| 0.1           |             0   |          13.2    |
| 0.1           |             0.5 |        15.95     |
| 0.1           |             0.9 |        18.75     |
| 0.01          |            0    |          19.2    |
| 0.01          |            0.5  |        5.45      | 
| 0.01          |            0.9  |        5.95      |
| 0.001         |           0     |          20      |
| 0.001         |           0.5   |        19.3      |
| 0.001         |           0.9   |        19.2      |


Observando la tabla la configuración de la red, con learning-rate=0.01
y momentum=0.5 obtengo el mejor resultado, un error discreto del
5.45%. Por lo tanto se realizo la gráfica de mse de train, validación
y test en función del número de épocas usando los datos
correspondientes a la ejecución que resultó en ese error.

Siendo el learning-rate cuanto se le permite aprender a la red en cada
caso de ejemplo y el momentum que determina cuanto influyen los casos
anteriores, se puede observar un patrón en la tabla, dataset
dos-elipses se beneficia de un learning-rate=0.01 y un momentum entre
0.5 y 0.9. En otras ejecuciones se obtuvo un error discreto mas bajo
con 0.9 que con 0.5 de momentum.

Ejercicio B: Arquitectura
=========================

Luego de realizar al igual que en el ejercicio A), 21 ejecuciones de
la red (sobre el dataset generado por el ejercicio C) del TP0) para
cada configuración de la capa intermedia, y quedándose con la mediana
de los errores discretos se obtiene la siguiente tabla: (también
encontrada en B/data.csv)


| Capa intermedia |   Error discreto      |
|-----------------|-----------------------|
| 2               |                44.15  |
| 5               |                 37.85 |
| 10              |                24.5   |
| 20              |                10.5   |
| 40              |                7.85   |


Se puede observar que para este dataset a medida que se aumentan la
cantidad de neuronas en la capa intermedia aumenta la precisión de la
red.  Las gráficas así como la tabla revelan que con 20 neuronas en la
capa intermedia se consiguen buenos resultados siendo mucho mas rápida
de entrenar que la red con 40 neuronas en la capa intermedia.


Ejercicio C: Regularización
===========================

Realizando 21 ejecuciones de cada configuración de la red pero en este
caso a diferencia de los ejercicios anteriores la medida que voy a
considerar representativa es la mediana sobre el error de prueba,
obteniendo la siguiente tabla:

| Entrenar |     Error         |
|----------|-------------------|
| 190      |          0.057159 |
| 150      |          0.063578 |
| 100      |          0.080437 |

Observando la tabla y las respectivas gráficas del mse en train,
validación y test de las ejecuciones que dieron esos errores, se puede
concluir lo siguiente: a media que se aumentan los datos de
entrenamiento y disminuyen los de validación tanto el error de test y
validación parecen disminuir, aunque en el extremo de 190 datos de
entrenamiento se puede observar que el error de validación se
estanca. Por lo que se podría decir que la configuración que usa el
75% para entrenar y 25% para validar en este dataset es una buena
elección.

Ejercicio D: Regularización
===========================

Modificando bp.c para implementar weight-decay, se ejecuto 21 veces la
configuración de la red con 0 datos para validación y con un gamma
variando entre 10^-8 a 1. Tomando la media entre el error de prueba se
puede ver que la gráfica con Gamma 0.0001 es la mejor opción. Pues
para valores mas chicos el error de entrenamiento decrece mientras que
el error de test crece, es decir, se produce overfitting. Para valores
más altos el sistema se vuelve mas rígido, en las gráficas se puede
ver que los errores quedan estancados en los mismos valores.

Ejercicio E: Dimensionalidad
============================

Luego de ejecutar 21 veces la configuración de la red para cada tamaño
de input y tomar la mediana del error discreto para armar la siguiente
tabla

| Cantidad de inputs del Dataset diagonal |  Error discreto |
|-----------------------------------------|-----------------|
| 2                                       |  11.16          |
| 4                                       |  13.77          |
| 8                                       |  15.42          |
| 16                                      |  16.39          |
| 32                                      |  20.63          |


| Cantidad de inputs del Dataset paralelo  |  Error discreto |
|------------------------------------------|-----------------|
| 2                                        |  9.88           |
| 4                                        |  12.93          |
| 8                                        |  15.71          |
| 16                                       |  17.94          |
| 32                                       |  12.07          |


Se puede observar que la red neuronal clasifica mucho mejor el dataset
diagonal, que como describí en el TP1, los arboles de decisión tienen
muchos problemas al clasificar datos de este dataset, mas aún cuando
los inputs aumentan. A pesar de que todas las gráficas de error son
crecientes, es claro que el error de la red neuronal es siempre menor.

En el caso del dataset paralelo la situación se revierte, pues los
arboles de clasificación tienen la ventaja respecto del input, pues en
este dataset solo deben fijarse en la primer componente para poder
realizar una clasificación correcta. En este caso la red neuronal
tiene una error más grande y es de esperar que siempre se comporte de
una manera menos eficiente que un árbol de decisión.
