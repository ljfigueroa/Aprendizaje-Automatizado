#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>


/* Función de densidad puntual de la distribución normal */
float pdf(float desvio, float media, double x)
{
	double tmp1,tmp2;
	tmp1 = -0.5 * pow((x-media) / desvio, 2);
	tmp2 = 1 / (desvio * sqrt(2* M_PI));
	return tmp2 * exp(tmp1);
}

/* Genera un número random entre [min,max) */
double double_random_between(double min, double max) {
	double r = drand48();
	return min + r * (max - min);
}

/* Genera valores aplicando el método de Rejection Sampling dentro del
 * intervalo [media-3*desvio_estandar, media+3*desvio_estandar] */
double generate_input(double desvio, double media)
{
	double inicio_intervalo,fin_intervalo,fppu, u,x;
	inicio_intervalo = media - desvio*3;
	fin_intervalo = media + desvio*3;
	
	for(;;) {
		x = double_random_between(inicio_intervalo, fin_intervalo);
		u = double_random_between(0.0,1.0); 
		if (u < pdf(desvio, media, x)) {
			return x;
		}
	}
}

void generate_data(int dinputs, double desvio, double media, int n, 
		   int clase, double (*fun)(double,double), FILE *f)
{
	int i, j;
	for (i=0; i < n; i++) {
		fprintf(f, "%lf, ",fun(desvio, media));
		for(j=1; j < dinputs; j++) 
			fprintf(f, "%lf, ",fun(desvio, 0));
		fprintf(f,"%d\n", clase);
	}
	return;
}

int main(int argc, char **argv)
{
	double c, desvio;
	int n, dinputs, i;
	FILE *dfile, *nfile;
	
	dfile = fopen("ejB.data", "w");
	nfile = fopen("ejB.names","w");

	scanf("%d %d %lf", &n,&dinputs,&c);
	desvio = c;

	/* Genero el .data */
	srand48(time(NULL));
	generate_data(dinputs, desvio, 1.0, n/2, 1, generate_input, dfile);
	generate_data(dinputs, desvio, -1.0, n/2, 0, generate_input, dfile);
    	fclose(dfile);

	/* Genero el .names */
	fprintf(nfile, "1, 0.\n\n");
	for (i = 0; i < dinputs; i++)
		fprintf(nfile, "input%d: continuous.\n",i+1);
	fclose(nfile);

	return 0;
}
