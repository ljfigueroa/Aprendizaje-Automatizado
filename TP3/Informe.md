
Ejercicio 1
===========

El nombre del programa es nb_n.c, se utilizo el código base dado.
Para compilar el programa ejecutar make.


Ejercicio 2: Dimensionalidad
============================

El clasificador Naive-Bayes siempre tiene un error porcentual promedio
menor que los árboles de decisión y la redes neuronales porque
inherentemente es bueno clasificando datos con la propiedad de que cada
atributo o feature es independiente del resto y a demás tienen una
distribución normal. En el caso del ej7 de la practica 1, los datos
fueron generados con los datasets paralelo y diagonal los cuales
poseen las mismas propiedades que hacen que un clasificador
naive-bayesiano sea ideal.

A pesar de lo desarrollado arriba, se observa que el problema inherente
del aumento de las dimensionalidades de los datos (sin aumentar la
cantidad de datos al entrenar) también afecta cuan efectivo es el
clasificador Naive-Bayes aunque no con la misma proporción que la
vista en los otros clasificadores con los que se lo compara.

Cuando se comparara con los clasificadores ideales que se hicieron en
la practica 1, se observa que son casi iguales los resultados
comparados con los del clasificador Naive-Bayes.


Ejercicio 3 - Límites del clasificador
======================================

Aclaración: para comparar los resultados de los distintos
clasificadores se trató de usar las mimas configuraciones para ambos
casos:

- Para la red neuronal se utilizo el .predict con la mejor
configuración que se encontró en el practico anterior learning rate
0.01 y momentum 0.5, con un error en el test de 4.45%. A demás:
     - 400 datos de entrenamiento
     - 100 datos de validación
     - 2000 datos de test
- Para el clasificador Naive-Bayes se utilizo la siguiente configuración:
     - 400 datos de entrenamiento
     - 2000 datos de test

El clasificador Naive-Bayes con Gaussianas no es un buen clasificador
para los datasets dos_elipses y espirales anidadas. Pues una de las
condiciones que lo hacen ideal para los datatsets del ejercicio
anterior no se cumplen ahora, las distribuciones de los atributos no
son gausianas, sino distribuciones uniformes. Las gráficas de los
.predicts muestran este problema al compararlos con los datos
obtenidos por las redes neuronales, donde las mismas hacen una mejor
clasificación de los datos.

Ejercicio 4
===========

El nombre del programa es nb_histograma.c, se utilizo el código base
dado. Para compilar el programa ejecutar make.

Las gráficas se realizaron con el conjunto de validación del mismo
tamaño que las redes neuronales (iguales al ejercicio anterior) . Los
resultados de las mismas son muy positivos, se puede observar una
notable mejora en el proceso de clasificación observando las gráficas
de los predict y la tabla con los errores promedio.

Las tablas fueron generadas usando el promedio de 20 ejecuciones por
cada configuración y al momento de graficar se busco entre los datos
generados el que tuviera la menor diferencia de error con el promedio
obtenido.

Si rubiera que elegir un número de bins fijo para cada ejecución sería
15 o 20, ambos produjeron a lo largo de las distintas experiencias los
mejores resultados.

Tabla de los errores promedio de dos_elipses:

| BINS |  Error de Entrenamiento | Error de Validación | Error de Test |
|------|-------------------------|---------------------|---------------|
| 5    | 15.225                  | 16.95               | 14.0175       |
| 10   | 4.725                   | 4.35                | 4.79          |
| 15   | 4.8125                  | 6.05                | 5.0275        |
| 20   | 4.1375                  | 5.95                | 4.97          |
| 25   | 3.6                     | 5.2                 | 4.865         |
| 30   | 4.2875                  | 8.3                 | 6.54          |



Tabla de los errores promedio de espirales anidadas:


| BINS |  Error de Entrenamiento |  Error de Validación |  Error de Test |
|------|-------------------------|----------------------|----------------|
| 5    | 38.121875               | 39.375               | 39.4875        |
| 10   | 32.215625               | 31.625               | 32.445         |
| 15   | 24.934375               | 26.9                 | 25.8425        |
| 20   | 27.953125               | 29.275               | 28.5925        |
| 25   | 27.184375               | 29.25                | 28.33          |
| 30   | 26.08125                | 28.9625              | 28.415         |


Para el datasets de las espirales anidadas sigue sin ser mejor que la
clasificación redes neuronales pero se puede concluir que por lo
observado se comporta mejor que una red con 10 neuronas y peor que una
red con 20 neuronas en la capa intermedia. La gráfica se realizo con
15 bins, siendo este el que tiene el menor error promedio.

La gráfica de dos_elipses muestra que casi se igualo el poder de
predicción de las redes neuronales, la gráfica entregada es producto
de usar 10 bins y tiene un error promedio de test del 4.79% (siendo el
de la red neuronal 4.45%), el cual es muy bajo. Se puede observar
claramente en la gráfica las "cajas" descriptas por el resumen que
se encuentra en la página de los datasets de la materia.
