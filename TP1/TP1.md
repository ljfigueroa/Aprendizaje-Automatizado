
Ejercicio 4
===========

Tras ejecutar C4.5 sobre los datos generados por el ejercicio c)
del TP0, con los valores 140, 700, 3500 y utilizando en cada caso un
conjunto de test de 10000 puntos, las gráficas de las predicciones
muestran que la cantidad de datos de entrenamiento parece ser
directamente proporcional con la precisión de los árboles de decisión.

Ejercicio 5: Sobreajuste y prunning
===================================

Se puede observar en este ejercicio el contraste de datasets que se
comportan completamente diferentes.

Cantidad promedio de nodos:
	 Comenzando con el dataset diagonal ó A, se puede observar en
las gráficas de la cantidad de nodos promedio, que a medida que
aumenta la cantidad de puntos de entrenamiento, la cantidad de nodos
promedio crece proporcionalmente. A pesar que la gráfica After
pruning muestra una disminución en la cantidad de nodos, la gráfica se
sigue asimilando a una función monótona creciente.

Contrariamente a lo que sucede con el dataset diagonal, en el
paralelo o B, a medida que aumentan los puntos de entrenamiento
disminuye levemente la cantidad de nodos promedio. La gráfica After
Pruning muestra una leve disminución casi imperceptible en la cantidad
promedio de nodos, asemejándose a una función constante a medida que
aumenta la cantidad de puntos de entrenamiento.

Una característica interesante que pude observar luego de realizar el
ej6.1 opcional, es que clasificar datos diagonal es complejo mientras
que datos de tipo paralelo es simple, pues solo se debe observar el
primer input. Esto se refleja sobre la cantidad nodos que los arboles
de decisión necesitan para clasificar los datos.

Error porcentual:
Al analizar las gráficas de Before y After Pruning la diferencia entre
ambas es ínfima y difícil de encontrar pero al observar los datos
promedios usados para graficar se nota una muy leve aumento en en los
errores porcentual promedio luego de podar el árbol.

Ejercicio 6: Resistencia al ruido
=================================

En la gráfica se puede observar como a medida que aumenta el desvío
estándar aumenta el error porcentual promedio.
Como el desvío estándar determina la amplitud de la campana de la
distribución normal generada en el TP0 y los centros de las clases
tanto en los datos diagonales como paralelo están "relativamente
cerca", genera que los datos de las clases se superpongan más y más a
medida que aumenta el desvío estándar, haciendo mas difícil el proceso
de clasificación

6.1. Usando el conocimiento previo del TP0 una forma de clasificar los
datos de la siguiente manera:

Paralelo:
  - si la primer componente (input1) es 1 el dato pertenece a
    la clase 1
  - si la primer componente (input1) es -1 el dato pertenece
    a la clase 0

Luego una forma de clasificar los datos es observar la primer
componente y si es menor que cero el datos decido que pertenece a la
clase 0 y en caso contrario a la clase 1.

Diagonal:
 - la clase 1 tiene centro en p1=(1,1,...,1)
 - la clase 0 tiene centro en p2=(-1,...,-1)

Luego una forma de clasificar los datos es considerarlos parte de un
espacio euclídeo y usar la la distancia euclidiana para determinar a
que un dato se encuentran mas cerca si p1 o p2. Luego dado un dato v,
si distancia(v,p1) < distancia(v,p2) entonces digo que v pertenece a
la clase 1, en caso contrario digo que v pertenece a la clase 0.

En las gráficas se puede observar que esta forma de clasificar tiene
un error porcentual promedio mucho mas bajo que la dada por C4.5,
aunque al igual el error aumenta de forma rápida a medida que aumenta
el tamaño de C.

Ejercicio 7:  Dimensionalidad
=============================

Los resultados graficados muestran que a medida que aumenta el
valor de d, el error porcentual promedio en el entrenamiento disminuye
pero sobre los casos de test aumenta. Esto se llama overfitting o
sobreajuste y lo que sucede es que a medida que aumenta d, C4.5 agrega
más nodos al árbol de decisión lo que provoca que la precisión sobre
los datos de entrenamiento crezca, se traduce en que el error
porcentual promedio sobre estos disminuya. Sin embargo, provoca que
decrezca la precisión sobre los casos independientes de test, que es
equivalente al aumento del error porcentual que se observa en la
gráfica.

Ejercicio 8
===========

Graficar los datos de xor.data muestra una relación entre x e y
(nombres dado por xor.names), en la gráfica están representados como
V1 y V2. La relación con los otros datos es indistinguible, por lo que
se los considera ruido.

Un árbol de clasificación de clase puede ser el siguiente:

Tomando los colores como las respectivas clases, donde:
  - color rojo  = clase 1
  - color verde = clase 0

Árbol:nev
* x <= 0
 * y <= 0 : 1
 * y >  0 : 0
* x >  0
 * y <= 0 : 0
 * y >  0 : 1

Al aplicar C4.5 a este problema, clasifica todos los datos como la
clase 0. Esto se debe a que hay demasiado ruido en los datos de
entrenamiento y no puede generar un árbol que clasifique correctamente
los puntos.
Dado que hay 200 datos de entrenamiento, donde la mitad pertenece a
una clase 1 y la otra mitad a la clase 0, esta clasificación provoca
un error del 50% al clasificar datos.

Ejecutar C4.5 con -v 2 devuelve :

    200 items, total weight 200.0
        Att x   no gain
        Att y   no gain
        no sensible splits  200.0/100.0

Mostrando que C4.5 no encuentra ganancia de expandir a través de x o
de y.
