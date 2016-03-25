#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>


/*Función de densidad puntual de la distribución normal*/
float pdf(float desvio, float media, double x)
{
	double tmp1,tmp2;
	tmp1 = -0.5 * pow((x-media) / desvio, 2);
	tmp2 = 1 / (desvio * sqrt(2* M_PI));
	return tmp2 * exp(tmp1);
}

double double_random_between(double min, double max) {
	double r = drand48();
	return min + r * (max - min);
}

/* genero inputs dentro del intervalo [media-3*desvio_estandar,
 * media+3*desvio_estandar] */
double input(double desvio, double media)
{
	double inicio,fin,fppu, u,x;
	inicio = media - desvio*3;
	fin = media + desvio*3;
	fppu = 1/(fin-inicio); // función de densidad puntual de la
			       // distribución uniforme
	
	for(;;) {
		x = double_random_between(inicio, fin);
		u = double_random_between(0.0,1.0); 
		if (u < pdf(desvio, media, x)/fppu) {
			return x;
		}
	}
}

int main(int argc, char **argv)
{
	int n, d, i, j, clase;
	double c, desvio, media;
	FILE *f;

	f = fopen("test2.csv", "w");
	scanf("%d %d %lf", &n,&d,&c);
	desvio = c;
	srand(time(NULL));

	clase = 1;
	for (i=0; i < n/2 ;i++) {
		if (i == 0) {
			media = 1;
			fprintf(f, "%lf, ",input(desvio, media));
			media = 0;
		}
		for(j=1; j < d ; j++) 
			fprintf(f, "%lf, ",input(desvio, media));
		fprintf(f,"%d \n", clase);
	}

	clase = 0;
	for (i=0; i < n/2 ;i++) {
		if (i == 0) {
			media = -1;
			fprintf(f, "%lf, ",input(desvio, media));
			media = 0;
		}
		for(j=1; j < d ; j++) 
			fprintf(f, "%lf, ",input(desvio, media));
		fprintf(f,"%d \n", clase);
	}

	
    	fclose(f);
	return 0;
}
