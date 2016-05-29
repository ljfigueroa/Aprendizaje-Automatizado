/*
nb_n.c :
        - Clasificador Naive Bayes usando la aproximacion de funciones normales
          para features continuos.
        - Formato de datos: c4.5.
        - La clase a predecir tiene que ser un numero comenzando de 0: por
          ejemplo, para 3 clases, las clases deben ser 0,1,2.

PMG - Ultima revision: 20/06/2001
*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

#define LOW 1.e-14               /*Minimo valor posible para una probabilidad*/
#define PI  3.141592653


int N_IN;           /*Total numbre of inputs*/
int N_Class;        /*Total number of classes (outputs)*/

int PTOT;           /* cantidad TOTAL de patrones en el archivo .data */
int PR;             /* cantidad de patrones de ENTRENAMIENTO */
int PTEST;          /* cantidad de patrones de TEST (archivo .test) */
                    /* cantidad de patrones de VALIDACION: PTOT - PR*/

int SEED;           /* semilla para la funcion rand(). Los posibles valores son:
                       SEED: -1: No mezclar los patrones: usar los primeros PR
                                 para entrenar y el resto para validar.
                                 Toma la semilla del rand con el reloj.
                              0: Seleccionar semilla con el reloj, y mezclar los
                                 patrones.
                             >0: Usa el numero leido como semilla, y mezcla los
                                 patrones.
                    */

int CONTROL;        /* Nivel de verbosity:
                       0 -> solo resumen
                       1 -> 0 + pesos
                       2 -> 1 + datos
                    */

int N_TOTAL;        /* Número de patrones a usar durante el entrenamiento */

/* Matrices globales  DECLARAR ACA LAS MATRICES NECESARIAS */

double **data;       /* Train data */
double **test;       /* Test  data */
int    *pred;        /* Clases predichas */
double **media;      /* Tabla con la media de cada feature por clase */
double **varianza;
int    *size;

int *seq;            /* Sequencia de presentacion de los patrones*/

/* Variables globales auxiliares */
char filepat[100];
int i,j,k;
/* Bandera de error */
int error;


/* --------------------------------------------------------------------------
define_matrix:
    Reserva espacio en memoria para todas las matrices declaradas.
    Todas las dimensiones son leidas del archivo .nb en la funcion arquitec().
---------------------------------------------------------------------------- */
int define_matrix(){

  int max;
  if(PTOT>PTEST) max=PTOT;
  else max=PTEST;

  seq =(int *)calloc(max,sizeof(int));
  pred=(int *)calloc(max,sizeof(int));
  if(seq==NULL||pred==NULL) return 1;

  data=(double **)calloc(PTOT,sizeof(double *));
  if(PTEST) test=(double **)calloc(PTEST,sizeof(double *));
  if(data==NULL||(PTEST&&test==NULL)) return 1;

  for(i=0;i<PTOT;i++){
    data[i]=(double *)calloc(N_IN+1,sizeof(double));
	if(data[i]==NULL) return 1;
  }
  for(i=0;i<PTEST;i++){
    test[i]=(double *)calloc(N_IN+1,sizeof(double));
	if(test[i]==NULL) return 1;
  }

/* ALLOCAR ESPACIO PARA LAS MATRICES DEL ALGORITMO */
  media = (double **)calloc(N_Class, sizeof(double *));
  if(media == NULL) return 1;
  for(i = 0; i < N_Class; i++) {
    media[i] = (double*)calloc(N_IN, sizeof(double));
    if(media[i]==NULL) return 1;
  }

  varianza = (double **)calloc(N_Class, sizeof(double *));
  if(varianza == NULL) return 1;
  for(i = 0; i < N_Class; i++) {
    varianza[i] = (double*)calloc(N_IN, sizeof(double));
    if(varianza[i]==NULL) return 1;
  }

  size=(int *)calloc(N_Class,sizeof(int));

  return 0;
}

/* ----------------------------------------------------------------------------
arquitec:
    Lee el archivo .nb e inicializa el algoritmo en funcion de los
    valores leidos filename es el nombre del archivo .nb (sin la extension).
---------------------------------------------------------------------------- */
int arquitec(char *filename){
  FILE *b;
  time_t t;

  /* Paso 1:leer el archivo con la configuracion */
  sprintf(filepat,"%s.nb",filename);
  b=fopen(filepat,"r");
  error=(b==NULL);
  if(error){
    printf("Error al abrir el archivo de parametros\n");
    return 1;
  }

  /* Dimensiones */
  fscanf(b,"%d",&N_IN);
  fscanf(b,"%d",&N_Class);

  /* Archivo de patrones: datos para train y para validacion */
  fscanf(b,"%d",&PTOT);
  fscanf(b,"%d",&PR);
  fscanf(b,"%d",&PTEST);

  /* Semilla para la funcion rand()*/
  fscanf(b,"%d",&SEED);

  /* Nivel de verbosity */
  fscanf(b,"%d",&CONTROL);

  fclose(b);


  /* Paso 2: Definir matrices para datos y parametros (e inicializarlos) */
  error=define_matrix();
  if(error){
    printf("Error en la definicion de matrices\n");
    return 1;
  }

  /* Chequear semilla para la funcion rand() */
  if(SEED==0) SEED=time(&t);

  /* Imprimir control por pantalla */
  printf("\nNaive Bayes con distribuciones normales:\nCantidad de entradas:%d",N_IN);
  printf("\nCantidad de clases:%d",N_Class);
  printf("\nArchivo de patrones: %s",filename);
  printf("\nCantidad total de patrones: %d",PTOT);
  printf("\nCantidad de patrones de entrenamiento: %d",PR);
  printf("\nCantidad de patrones de validacion: %d",PTOT-PR);
  printf("\nCantidad de patrones de test: %d",PTEST);
  printf("\nSemilla para la funcion rand(): %d",SEED);

  return 0;
}

/* ----------------------------------------------------------------------------
read_data:
    Lee los datos de los archivos de entrenamiento (.data) y test (.test)
    donde filename es el nombre de los archivos (sin extension).
    La cantidad de datos y la estructura de los archivos fue leida en
    la funcion arquitec().
    Los registros en el archivo pueden estar separados por blancos ( o tab )
    o por comas.
---------------------------------------------------------------------------- */
int read_data(char *filename){

  FILE *fpat;
  double valor;
  int separador;

  sprintf(filepat,"%s.data",filename);
  fpat=fopen(filepat,"r");
  error=(fpat==NULL);
  if(error){
    printf("Error al abrir el archivo de datos\n");
    return 1;
  }

  if(CONTROL>1) printf("\n\nDatos de entrenamiento:");

  for(k=0;k<PTOT;k++){
    if(CONTROL>1) printf("\nP%d:\t",k);
    for(i=0;i<N_IN+1;i++){
      fscanf(fpat,"%lf",&valor);
      data[k][i]=valor;
      if(CONTROL>1) printf("%lf\t",data[k][i]);
      separador=getc(fpat);
      if(separador!=',') ungetc(separador,fpat);
    }
  }
  fclose(fpat);

  if(!PTEST) return 0;

  sprintf(filepat,"%s.test",filename);
  fpat=fopen(filepat,"r");
  error=(fpat==NULL);
  if(error){
    printf("Error al abrir el archivo de test\n");
    return 1;
  }

  if(CONTROL>1) printf("\n\nDatos de test:");

  for(k=0;k<PTEST;k++){
    if(CONTROL>1) printf("\nP%d:\t",k);
    for(i=0;i<N_IN+1;i++){
      fscanf(fpat,"%lf",&valor);
      test[k][i]=valor;
      if(CONTROL>1) printf("%lf\t",test[k][i]);
      separador=getc(fpat);
      if(separador!=',') ungetc(separador,fpat);
    }
  }
  fclose(fpat);
  return 0;
}

/* ----------------------------------------------------------------------------
shuffle:
    Mezcla el vector seq al azar.
    El vector seq es un indice para acceder a los patrones.
    Los patrones mezclados van desde seq[0] hasta seq[hasta-1], esto permite
    separar la parte de validacion de la de train.
---------------------------------------------------------------------------- */
void shuffle(int hasta){
   double x;
   int tmp;
   int top,select;

   top=hasta-1;
   while (top > 0) {
	x = (double)rand();
	x /= RAND_MAX;
	x *= (top+1);
	select = (int)x;
	tmp = seq[top];
	seq[top] = seq[select];
	seq[select] = tmp;
	top --;
   }
  if(CONTROL>3) {printf("End shuffle\n");fflush(NULL);}
}

double dp_nomal(double x, double m, double v)
{
    double tmp1 = 1 / sqrt(2 * M_PI * v);
    double tmp2 = exp( -pow(x - m, 2) / (2 * v) );
    return tmp1 * tmp2;
}
/* ----------------------------------------------------------------------------
prob:
    Calcula la probabilidad de obtener el valor x para el input feature y la
    clase.
    Aproxima las probabilidades por distribuciones normales.
---------------------------------------------------------------------------- */
double prob(double x,int feature,int clase)  {

  double mean = media[clase][feature];
  double variance = varianza[clase][feature];
  double prob = dp_nomal(x,mean,variance);

  return prob;
}

/* ---------------------------------------------------------------------------
output:
    Calcula la probabilidad de cada clase dado un vector de entrada *input
    usa el log(p(x)) (sumado).
    Devuelve la de mayor probabilidad.
---------------------------------------------------------------------------- */
int output(double *input){

  double prob_de_clase;
  double max_prob=-1e40;
  int clase_MAP;

  for(k=0;k<N_Class;k++) {
    prob_de_clase=0.;

    /* calcula la probabilidad de cada feature individual dada la clase y
       la acumula*/
    for(i=0;i<N_IN;i++)
        prob_de_clase += log( prob( input[i] ,i ,k ) );

    /* agrega la probabilidad a priori de la clase */
    /*COMPLETAR*/
    prob_de_clase += log(size[k]/N_IN);

    /* guarda la clase con prob maxima */
    if (prob_de_clase>=max_prob){
      max_prob=prob_de_clase;
      clase_MAP=k;
    }
  }

  return clase_MAP;
}

/* ----------------------------------------------------------------------------
propagar:
    Calcula las clases predichas para un conjunto de datos.
    La matriz S tiene que tener el formato adecuado ( definido en arquitec() ).
    pat_ini y pat_fin son los extremos a tomar en la matriz.
    usar_seq define si se accede a los datos directamente o a travez del
    indice seq.
    Los resultados (las propagaciones) se guardan en la matriz seq.
----------------------------------------------------------------------------- */
double propagar(double **S,int pat_ini,int pat_fin,int usar_seq){

  double mse=0.0;
  int nu;
  int patron;

  for (patron=pat_ini; patron < pat_fin; patron ++) {

   /*nu tiene el numero del patron que se va a presentar*/
    if(usar_seq) nu = seq[patron];
    else         nu = patron;

    /*clase MAP para el patron nu*/
    pred[nu]=output(S[nu]);

    /*actualizar error*/
    if(S[nu][N_IN]!=(double)pred[nu]) mse+=1.;
  }


  mse /= ( (double)(pat_fin-pat_ini));

  if(CONTROL>3) {printf("End prop\n");fflush(NULL);}

  return mse;
}

/* ----------------------------------------------------------------------------
train:
    Ajusta los parametros del algoritmo a los datos de entrenamiento.
    Guarda los parametros en un archivo de control.
    Calcula porcentaje de error en ajuste y test.
----------------------------------------------------------------------------- */
int train(char *filename){

  int feature,clase;
  double sigma,me;
  double train_error,valid_error,test_error;
  FILE *salida,*fpredic;

  /*Asigno todos los patrones del .data como entrenamiento porque este metodo
  no requiere validacion*/
  N_TOTAL=PTOT;
  /*N_TOTAL=PR; si hay validacion*/
  for(k=0;k<PTOT;k++) seq[k]=k;  /* inicializacion del indice de acceso a
                                    los datos */

  /*efectuar shuffle inicial de los datos de entrenamiento si SEED != -1
  (y hay validacion)*/
  if(SEED>-1 && N_TOTAL<PTOT){
    srand((unsigned)SEED);
    shuffle(PTOT);
  }


  /*Calcular probabilidad intrinseca de cada clase*/

  /* Calculo la cantidad de datos en cada clase */
  for(k = 0; k < PTOT; k++) {
      clase = data[k][N_IN];
      size[clase]++;
  }

  /*Calcular media y desv.est. por clase y cada atributo*/

  /* Calculo la media de todos los features */
  for(i = 0; i < N_IN; i++) {
      for(k = 0; k < PTOT; k++) {
          clase = data[k][N_IN];
          media[clase][i] += data[k][i];
      }
  }
  /* Divido por la cantidad de elementos de cada clase */
  for(i = 0; i < N_Class; i++) {
      for(k = 0; k < N_IN; k++) {
          media[i][k] /=  size[i];
      }
  }

  /* Varianza */
  for(i = 0; i < N_IN; i++) {
      for(k = 0; k < PTOT; k++) {
          clase = data[k][N_IN];
          varianza[clase][i] += pow(data[k][i] - media[clase][i], 2);
      }
  }

  /* Divido por la cantidad de elementos de cada clase */
  for(i = 0; i < N_Class; i++) {
      for(k = 0; k < N_IN; k++) {
          varianza[i][k] /=  size[i];
      }
  }

  /*calcular error de entrenamiento*/
  train_error=propagar(data,0,PR,1);
  /*calcular error de validacion; si no hay, usar mse_train*/
  if(PR==PTOT) valid_error=train_error;
  else         valid_error=propagar(data,PR,PTOT,1);
  /*calcular error de test (si hay)*/
  if (PTEST>0) test_error =propagar(test,0,PTEST,0);
  else         test_error =0.;
  /*mostrar errores*/
  printf("\nFin del entrenamiento.\n\n");
  printf("Errores:\nEntrenamiento:%f%%\n",train_error*100.);
  printf("Validacion:%f%%\nTest:%f%%\n",valid_error*100.,test_error*100.);
  if(CONTROL) fflush(NULL);

  /* archivo de predicciones */
  sprintf(filepat,"%s.predic",filename);
  fpredic=fopen(filepat,"w");
  error=(fpredic==NULL);
  if(error){
    printf("Error al abrir archivo para guardar predicciones\n");
    return 1;
  }
  for(k=0; k < PTEST ; k++){
    for( i = 0 ;i< N_IN;i++) fprintf(fpredic,"%f\t",test[k][i]);
    fprintf(fpredic,"%d\n",pred[k]);
  }
  fclose(fpredic);

  return 0;
}


int main(int argc, char **argv){

  if(argc!=2){
    printf("Modo de uso: nb <filename>\ndonde filename es el nombre del archivo (sin extension)\n");
    return 0;
  }

  /* Defino la estructura*/
  error=arquitec(argv[1]);
  if(error){
    printf("Error en la definicion de parametros\n");
    return 1;
  }

  /* Leo los datos */
  error=read_data(argv[1]);
  if(error){
    printf("Error en la lectura de datos\n");
    return 1;
  }

  /* Ajusto los parametros y calcula errores en ajuste y test */
  error=train(argv[1]);
  if(error){
    printf("Error en el ajuste\n");
    return 1;
  }

  return 0;
}
